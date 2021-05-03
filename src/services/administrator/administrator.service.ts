import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { AddAdministratorDto } from 'src/dtos/administrator/add.administrator.dto';
import { EditAdministratorDto } from 'src/dtos/administrator/edit.administrator.dto';
import { Administrator } from 'src/entities/administrator.entity';
import { Repository } from 'typeorm';
import * as crypto from 'crypto';
import { ApiResponse } from 'src/misc/api.response.class';
import { AdministratorToken } from 'src/entities/administrator-token.entity';

@Injectable()
export class AdministratorService {
    //uvoz svih repozitorijuma 
    constructor(
        //ubacujemo repoz Administrator koji je privatan i bice samo koristen unutar AdministratorService
        //Van tog servisa ne moze koristiti ovaj repozitorijum
        @InjectRepository(Administrator) private readonly administrator:Repository<Administrator>,
        @InjectRepository(AdministratorToken) private readonly administratorToken:Repository<AdministratorToken>
    ){}

    //getAll() treba da vrati obecanje(Promise) da ce vratiti niz administrator-a
    getAll():Promise<Administrator[]>{
        return  this.administrator.find();
    }
    //getById treba da vrati obecanje(Promise) da ce vratiti jednog administrator-a
    //parametar koji prosledjujemo je upravo taj id. TypeOrm trazi vrijednost id-a u polju
    //koje je u nasem entitetu definisano kao @PrimaryGeneratedColumn
    async getById(id:number):Promise<Administrator|ApiResponse>{
        let admin:Administrator=await this.administrator.findOne(id);
        if(admin===undefined)
        {
            return new ApiResponse('error',-1001);
        }
        return admin;
    }

    //servis ce dobiti iz spoljasnjeg okruzenja data objekat koji ce biti AddAdministratorDto
    //Dobice username, password, a treba da kreira passwordHash pa cemo obaviti transformaciju iz
    //dto -> model
    //username -> model
    //password (obrada)->passwordHash
    add(data:AddAdministratorDto):Promise<Administrator|ApiResponse>{
        
        const passwordHash=crypto.createHash('sha512');
        passwordHash.update(data.password);
        
        const passwordHashString=passwordHash.digest('hex').toUpperCase();

        let newAdministrator:Administrator=new Administrator();
        newAdministrator.username=data.username;
        newAdministrator.passwordHash=passwordHashString;

        return new Promise((resolve)=>{
            this.administrator.save(newAdministrator)
            .then(result=>resolve(result))
            .catch(()=>{
                resolve(new ApiResponse('error',-1001));
            })
        })
    }

    async editById(id:number, data:EditAdministratorDto):Promise<Administrator|ApiResponse>{
        let admin:Administrator=await this.administrator.findOne(id); 

        if(admin===undefined)
        {   
            return new ApiResponse('error',-1001);
        }
        const passwordHash=crypto.createHash('sha512');
        passwordHash.update(data.password);
        
        const passwordHashString=passwordHash.digest('hex').toUpperCase();

        admin.passwordHash=passwordHashString;

        return this.administrator.save(admin);
    }

    async getByUsername(username:string):Promise<Administrator|null>{
        const admin=await this.administrator.findOne({
            username:username
        })

        if(!admin)
        {
            return null;
        }
        return admin;

    }

    async addToken(administratorId:number, token:string, expiresAt:string)
    {
        const administratorToken:AdministratorToken=new AdministratorToken();
        administratorToken.administratorId=administratorId;
        administratorToken.token=token;
        administratorToken.expiresAt=expiresAt;

        return await this.administratorToken.save(administratorToken);
    }

    async getAdministratorToken(token:string):Promise<AdministratorToken>
    {
        return await this.administratorToken.findOne({
            token:token
        });
    }

    async invalidateToken(token:string):Promise<AdministratorToken|ApiResponse>
    {
        const administratorToken=await this.administratorToken.findOne({
            token:token
        })

        if(!administratorToken)
        {
            return new ApiResponse('error',-10001, 'No such refresh token');
        }

        administratorToken.isValid=0;

        await this.administratorToken.save(administratorToken);

        return await this.getAdministratorToken(token);
    }

    async invalidateUserTokens(administratorId:number):Promise<(AdministratorToken|ApiResponse)[]>
    {
        const administratorTokens=await this.administratorToken.find({administratorId:administratorId});

        const results=[];

        for(const administratorToken of administratorTokens)
        {
            results.push(this.invalidateToken(administratorToken.token));
        }

        return results;
    }
}
