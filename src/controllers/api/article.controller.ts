import { Body, Controller, Delete, Param, Patch, Post, Req, UploadedFile, UseGuards, UseInterceptors } from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { Crud } from "@nestjsx/crud";
import { Article } from "src/entities/article-entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ArticleService } from "src/services/article/article.service";
import {diskStorage} from "multer";
import { StorageConfiguration } from "config/storage.configuration";
import { PhotoService } from "src/services/photo/photo.services";
import { Photo } from "src/entities/photo.entity";
import { ApiResponse } from "src/misc/api.response.class";
import * as fileType from 'file-type';
import * as fs from 'fs';
import * as sharp from 'sharp';
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { RoleCheckerGuard } from "src/misc/role.checker.file";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";

@Controller('api/article')
@Crud({
    model:{
        type:Article
    },
    params:{
        id:{
            field:'articleId',
            type:'number',
            primary:true
        }
    },
    query:{
        join:{
            category:{
                eager:true
            },
            photos:{
                eager:true
            },
            articlePrices:{
                eager:false
            },
            articleFeatures:{
                eager:false
            },
            features:{
                eager:false
            }
        }
    },
    routes:{
        only:[
            "getOneBase",
            "getManyBase"
        ],
        getOneBase:{
            decorators:[
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator','user')
            ]
        },
        getManyBase:{
            decorators:[
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator','user')
            ]
        }
    }
})
export class ArticleController{
    constructor(
        public service:ArticleService,
        public photoService:PhotoService                //pomocu njega insert-ujemo novi photo
    ){}

    @Post() 
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')                               // http://localhost:3000/api/article/createdFull/
    createFullArticle(@Body() data:AddArticleDto):Promise<Article|ApiResponse>{
        return this.service.createFullArticle(data);
    }

    @Patch(':id')
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')
    editFullArticle(@Param('id') id:number, @Body() data:EditArticleDto)
    {
        return this.service.editFullArticle(id,data);
    }

    @Post(':id/uploadPhoto') 
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')                           //http://localhost:3000/api/article/:id/uploadPhoto
    @UseInterceptors(
    FileInterceptor('photo',{
        storage:diskStorage({                                  //preciznije navodimo gdje se cuva fajl
            destination:StorageConfiguration.photo.destination,           //u kom folderu ce biti sacuvane slike
            filename:(req, file, callback)=>{                   //kako ce se zvati fajl koji se upload-uje
                let originalFileName    =   file.originalname; //dolazimo do originalnog naziva fajla
                let optimizedOriginal   =   originalFileName.replace(/\s+/g, '-'); //regularni izraz izmedju 2 slash-a, gdje god se pojavi space karakter zamijeni ga znakom "-"
                
                let currentDate =   new Date();                 //trenutni datum
                let datePart    =   '';
                datePart        =   datePart+currentDate.getFullYear().toString();
                datePart        =   datePart+(currentDate.getMonth()+1).toString();
                datePart        =   datePart+currentDate.getDate().toString();

                //prilikom cuvanja fotografije hocemo nakon datuma da ubacimo i neki random broj od 10 cifara, kako bi korisnik imao vecu vjerovatnocu da nece upload-ovati sliku pod istim nazivom
                let randomPart:string=new Array(10)
                .fill(0)
                .map(e=>(Math.random()*9).toFixed(0).toString())
                .join('');

                let fileName    =   datePart + '-' + randomPart + '-' + optimizedOriginal;

                callback(null, fileName);

            }
        }),
        fileFilter: (req,file,callback)=>{
            //Provjera ekstenzije .png .jpg
            if(!file.originalname.match(/\.(jpg|png)$/))
            {
                req.fileFilterError='Bad file extension';
                callback(null,false);
                return;
            }
            //Provjera tipa sadrzaja: image/jpeg, image/png
            if(!(file.originalname.includes('jpeg')||file.mimetype.includes('png')))
            {
                req.fileFilterError='Bad file content';
                callback(null, false);
                return;
            }

            //Ako je sve proslo kako treba
            callback(null,true);
        },
        //Koliko fajlova prihvatamo da bude upload-ovano
        limits:{  
             files:1,
             fileSize:StorageConfiguration.photo.maxFileSize
        }
    })
    )
    async uploadPhoto(@Param('id') articleId:number, @UploadedFile() photo, @Req() req):Promise<Photo|ApiResponse>
    {
        

        //Da li u ovom req postoji fileFilterError
        if(req.fileFilterError)
        {
            return new ApiResponse('error',-4002,req.fileFilterError);
        }

        //Ako uopste nema upload-ovane fotografije
        if(!photo)
        {
            return new ApiResponse('error',-4002, 'File not uploaded');
        }

        const fileTypeResult=await fileType.fromFile(photo.path);
        if(!fileTypeResult)
        {
            fs.unlinkSync(photo.path);
            return new ApiResponse('error',-4002,'Cannot detect file type');
        }

        //koji je pravi file-type, uzimamo njegov mimetype
        const realMimeType=fileTypeResult.mime;
        if(!(realMimeType.includes('jpeg')||realMimeType.includes('png')))
        {
            fs.unlinkSync(photo.path);
            return new ApiResponse('error', -4002,'Bad file content type');
        }

        await this.createResizeImage(photo, StorageConfiguration.photo.resize.thumb);
        await this.createResizeImage(photo, StorageConfiguration.photo.resize.small);

        let imagePath=photo.filename;       //zapis u bazu podataka

        const newPhoto =new Photo();
        newPhoto.articleId=articleId;
        newPhoto.imagePath=photo.filename;

        const savedPhoto =await this.photoService.add(newPhoto);

        if(!savedPhoto)
        {
            return new ApiResponse('error',-4001);
        }

        return savedPhoto;
    }


    async createResizeImage(photo, resizeSettings)
    {
        const originalFilePath=photo.path;
        const fileName=photo.filename;

        const destinationFilePath=
            StorageConfiguration.photo.destination+
            resizeSettings.destination+
            fileName;

        await sharp(originalFilePath)
            .resize({
                fit:'cover',
                width:resizeSettings.width,
                height:resizeSettings.height
            })
            .toFile(destinationFilePath);
    }

    @Delete(':articleId/deletePhoto/:photoId')
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')
    public async deletePhoto(@Param('articleId') articleId:number, @Param('photoId') photoId:number)
    {
        //pronaci fotografiju iz service-a
        const photo=await this.photoService.findOne({
            articleId:articleId,
            photoId:photoId
        })

        if(!photo)
        {
            return new ApiResponse('error',-4004,'Photo not found');
        }

        try
        {
            fs.unlinkSync(StorageConfiguration.photo.destination + photo.imagePath);
            fs.unlinkSync(StorageConfiguration.photo.destination + StorageConfiguration.photo.resize.thumb.destination + photo.imagePath)
            fs.unlinkSync(StorageConfiguration.photo.destination + StorageConfiguration.photo.resize.small.destination + photo.imagePath)

        }catch(e){}

        //informacija na koliko redova je njen proces uticao i nalazi se pod poljem .affected
        const deleteResult=await this.photoService.deleteById(photoId);
        if(deleteResult.affected===0)
        {
            return new ApiResponse('error',-4004,'Photo not found');
        }
        return new ApiResponse('ok',0,'Photo deleted');
    }
}
