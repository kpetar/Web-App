import { Body, Controller, Post, Put, Req } from "@nestjs/common";
import { LoginAdministratorDto } from "src/dtos/administrator/login.administrator.dto";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as crypto from 'crypto';
import { ApiResponse } from "src/misc/api.response.class";
import { LoginInfoDto } from "src/dtos/auth/login.info.dto";
import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";
import  {Request} from 'express';
import * as jwt from 'jsonwebtoken';
import { jwtSecret } from "config/jwt.secret";
import { UserRegistrationDto } from "src/dtos/user/user.registration.dto";
import { User } from "src/entities/user.entity";
import { UserService } from "src/services/user/user.service";
import { LoginUserDto } from "src/dtos/user/login.user.dto";

@Controller('authorization')
export class AuthorizationController{
    constructor(
        public administratorService:AdministratorService,
        public userService:UserService
    ){}

    
@Post('administrator/login') //http://localhost:3000/authorization/administrator/login
async doAdministratorLogin(
     @Body() data:LoginAdministratorDto,
     @Req() request:Request)
     :Promise<LoginInfoDto|ApiResponse>{
    
     const administrator=await this.administratorService.getByUsername(data.username);

    if(!administrator)
    {
        return new Promise(resolve=>{
            resolve(new ApiResponse('error', -3001));
        })
    }

    const passwordHash=crypto.createHash('sha512');
    passwordHash.update(data.password);    
    const passwordHashString=passwordHash.digest('hex').toUpperCase();

    if(administrator.passwordHash!==passwordHashString)
    {
        return new Promise(resolve=>{
            resolve(new ApiResponse('error', -3002));
        })
    }

    //formirati jedan resurs koji se treba poslati
    const jwtData=new JwtDataDto();
    jwtData.id=administrator.administratorId;
    jwtData.role="administrator";
    jwtData.identity=administrator.username;
    
    //da bi dosli do odredjenog tokena, trebaju nam trenutni datum i vrijeme
    let currentTime=new Date();
    currentTime.setDate(currentTime.getDate()+14); // trenutno vrijeme +14 dana
    
    //konvertujemo ga u time stamp
    const expireTimeStamp=currentTime.getTime()/1000; //da bi se dobilo u sekundama

    jwtData.exp=expireTimeStamp;
    //sledece polje je ip adresa, da bismo je uzeli, ukljucimo Request(baziran na express)
    jwtData.ip=request.ip.toString();
    jwtData.userAgent=request.headers["user-agent"];

    
    //u jwtData se nalaze podaci. Da bi se formirao token na osnovu ovih podataka treba da se potpise(metoda sign())
    let token:string=jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const responseObject=new LoginInfoDto(
        administrator.administratorId,
        administrator.username,
        token
    )

    return new Promise(resolve=>resolve(responseObject));
}

@Post('user/register') //http://localhost:3000/authorization/user/register
userRegistration(@Body() data:UserRegistrationDto):Promise<User|ApiResponse>{
    return this.userService.userRegistration(data);
}

@Post('user/login') //http://localhost:3000/authorization/user/login
async doUserLogin(
     @Body() data:LoginUserDto,
     @Req() request:Request)
     :Promise<LoginInfoDto|ApiResponse>{
    
     const user=await this.userService.getByEmail(data.email);

    if(!user)
    {
        return new Promise(resolve=>{
            resolve(new ApiResponse('error', -3001));
        })
    }

    const passwordHash=crypto.createHash('sha512');
    passwordHash.update(data.password);    
    const passwordHashString=passwordHash.digest('hex').toUpperCase();

    if(user.passwordHash!==passwordHashString)
    {
        return new Promise(resolve=>{
            resolve(new ApiResponse('error', -3002));
        })
    }

    //formirati jedan resurs koji se treba poslati
    const jwtData=new JwtDataDto();
    jwtData.id=user.userId;
    jwtData.role="user";
    jwtData.identity=user.email;
    
    //da bi dosli do odredjenog tokena, trebaju nam trenutni datum i vrijeme
    let currentTime=new Date();
    currentTime.setDate(currentTime.getDate()+14); // trenutno vrijeme +14 dana
    
    //konvertujemo ga u time stamp
    const expireTimeStamp=currentTime.getTime()/1000; //da bi se dobilo u sekundama

    jwtData.exp=expireTimeStamp;
    //sledece polje je ip adresa, da bismo je uzeli, ukljucimo Request(baziran na express)
    jwtData.ip=request.ip.toString();
    jwtData.userAgent=request.headers["user-agent"];

    
    //u jwtData se nalaze podaci. Da bi se formirao token na osnovu ovih podataka treba da se potpise(metoda sign())
    let token:string=jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const responseObject=new LoginInfoDto(
        user.userId,
        user.email,
        token
    )

    return new Promise(resolve=>resolve(responseObject));
}

}