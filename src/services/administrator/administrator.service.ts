import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Administrator } from 'src/entities/administrator.entity';
import { Repository } from 'typeorm';

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

}
