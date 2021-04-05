import { Body, Controller, Param, Post, UploadedFile, UseInterceptors } from "@nestjs/common";
import { FileInterceptor } from "@nestjs/platform-express";
import { Crud } from "@nestjsx/crud";
import { Article } from "entities/article-entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { ArticleService } from "src/services/article/article.service";
import {diskStorage} from "multer";
import { StorageConfiguration } from "config/storage.configuration";
import { PhotoService } from "src/services/photo/photo.services";
import { Photo } from "entities/photo.entity";
import { ApiResponse } from "src/misc/api.response.class";

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
                eager:true
            },
            articleFeatures:{
                eager:true
            },
            features:{
                eager:true
            }
        }
    }
})
export class ArticleController{
    constructor(
        public service:ArticleService,
        public photoService:PhotoService                //pomocu njega insert-ujemo novi photo
    ){}

    @Post('createdFull')                                // http://localhost:3000/api/article/createdFull/
    createFullArticle(@Body() data:AddArticleDto){
        return this.service.getFullArticle(data);
    }

    @Post(':id/uploadPhoto')                            //http://localhost:3000/api/article/:id/uploadPhoto
    @UseInterceptors(
    FileInterceptor('photo',{
        storage:diskStorage({                                  //preciznije navodimo gdje se cuva fajl
            destination:StorageConfiguration.photoDestination,           //u kom folderu ce biti sacuvane slike
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
                callback(new Error('Bad file extension'),false);
                return;
            }
            //Provjera tipa sadrzaja: image/jpeg, image/png
            if(!(file.originalname.includes('jpeg')||file.mimetype.includes('png')))
            {
                callback(new Error('Bad file content'), false);
                return;
            }

            //Ako je sve proslo kako treba
            callback(null,true);
        },
        //Koliko fajlova prihvatamo da bude upload-ovano
        limits:{  
             files:1,
             fileSize:StorageConfiguration.photoMaxFileSize
        }
    })
    )
    async uploadPhoto(@Param('id') articleId:number, @UploadedFile() photo):Promise<Photo|ApiResponse>
    {
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
}
