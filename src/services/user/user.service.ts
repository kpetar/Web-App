import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UserRegistrationDto } from 'src/dtos/user/user.registration.dto';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';
import * as crypto from 'crypto';
import { ApiResponse } from 'src/misc/api.response.class';
import { UserToken } from 'src/entities/user-token.entity';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
    constructor(@InjectRepository(User) private readonly user:Repository<User>,
                @InjectRepository(UserToken) private readonly userToken:Repository<UserToken>            
    ){
        super(user);
    }

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

    async addToken(userId:number, token:string, expiresAt:string)
    {
        const userToken:UserToken=new UserToken();
        userToken.userId=userId;
        userToken.token=token;
        userToken.expiresAt=expiresAt;

        return await this.userToken.save(userToken);
    }

    async getUserToken(token:string):Promise<UserToken>
    {
        return await this.userToken.findOne({
            token:token
        });
    }

    async invalidateToken(token:string):Promise<UserToken|ApiResponse>
    {
        const userToken=await this.userToken.findOne({
            token:token
        })

        if(!userToken)
        {
            return new ApiResponse('error',-10001, 'No such refresh token');
        }

        userToken.isValid=0;

        await this.userToken.save(userToken);

        return await this.getUserToken(token);
    }

    async invalidateUserTokens(userId:number):Promise<(UserToken|ApiResponse)[]>
    {
        const userTokens=await this.userToken.find({userId:userId});

        const results=[];

        for(const userToken of userTokens)
        {
            results.push(this.invalidateToken(userToken.token));
        }

        return results;
    }
    
}
