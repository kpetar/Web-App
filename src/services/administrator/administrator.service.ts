import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { AddAdministratorDto } from 'src/dtos/administrator/add.administrator.dto';
import { EditAdministratorDto } from 'src/dtos/administrator/edit.administrator.dto';
import { Administrator } from 'entities/administrator.entity';
import { Admin, Repository } from 'typeorm';
import * as crypto from 'crypto';
import { LoginAdministratorDto } from 'src/dtos/administrator/login.administrator.dto';

@Injectable()
export class AdministratorService {
    //uvoz svih repozitorijuma 
    constructor(
        //ubacujemo repoz Administrator koji je privatan i bice samo koristen unutar AdministratorService
        //Van tog servisa ne moze koristiti ovaj repozitorijum
        @InjectRepository(Administrator) private readonly administrator:Repository<Administrator>
    ){}

    //getAll() treba da vrati obecanje(Promise) da ce vratiti niz administrator-a
    getAll():Promise<Administrator[]>{
        return  this.administrator.find();
    }
    //getById treba da vrati obecanje(Promise) da ce vratiti jednog administrator-a
    //parametar koji prosledjujemo je upravo taj id. TypeOrm trazi vrijednost id-a u polju
    //koje je u nasem entitetu definisano kao @PrimaryGeneratedColumn
    getById(id:number):Promise<Administrator>{
        return this.administrator.findOne(id);
    }

    //servis ce dobiti iz spoljasnjeg okruzenja data objekat koji ce biti AddAdministratorDto
    //Dobice username, password, a treba da kreira passwordHash pa cemo obaviti transformaciju iz
    //dto -> model
    //username -> model
    //password (obrada)->passwordHash
    add(data:AddAdministratorDto){
        
        const passwordHash=crypto.createHash('sha512');
        passwordHash.update(data.password);
        
        const passwordHashString=passwordHash.digest('hex').toUpperCase();

        let newAdministrator:Administrator=new Administrator();
        newAdministrator.username=data.username;
        newAdministrator.passwordHash=passwordHashString;

        return this.administrator.save(newAdministrator);
    }

    async editById(id:number, data:EditAdministratorDto):Promise<Administrator>{
        let admin:Administrator=await this.administrator.findOne(id); 

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
}
