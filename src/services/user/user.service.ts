import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UserRegistrationDto } from 'src/dtos/user/user.registration.dto';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';
import * as crypto from 'crypto';
import { ApiResponse } from 'src/misc/api.response.class';

@Injectable()
export class UserService {
    constructor(@InjectRepository(User) private readonly user:Repository<User>){}

    async userRegistration(data:UserRegistrationDto):Promise<User|ApiResponse>
    {
        const passwordHash=crypto.createHash('sha512');
        passwordHash.update(data.password);
        const passwordHashString=passwordHash.digest('hex').toUpperCase();

        const newUser:User=new User();
        newUser.email=data.email;
        newUser.passwordHash=passwordHashString;
        newUser.forename=data.forename;
        newUser.surname=data.surname;
        newUser.phoneNumber=data.phoneNumber;
        newUser.postalAddress=data.postalAddress;

        return new Promise((resolve)=>{
             this.user.save(newUser)
            .then(result=>resolve(result))
            .catch(()=>{
                resolve(new ApiResponse('error', -6001,'This account has cannot been created'));
            })
        })
    }

    async getById(id:number){
        return await this.user.findOne(id);
    }

    async getByEmail(email:string){
        return await this.user.findOne({
            email:email
        });
    }
    
}
