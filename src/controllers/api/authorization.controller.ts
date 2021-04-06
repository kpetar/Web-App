import { Body, Controller, Post, Req } from "@nestjs/common";
import { Administrator } from "src/entities/administrator.entity";
import { LoginAdministratorDto } from "src/dtos/administrator/login.administrator.dto";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as crypto from 'crypto';
import { ApiResponse } from "src/misc/api.response.class";
import { LoginInfoAdministratorDto } from "src/dtos/administrator/login.info.administrator.dto";
import { JwtDataAdministratorDto } from "src/dtos/administrator/jwt.data.administrator.dto";
import  {Request} from 'express';
import * as jwt from 'jsonwebtoken';
import { jwtSecret } from "config/jwt.secret";

@Controller('authorization')
export class AuthorizationController{
    constructor(
        public administratorService:AdministratorService
    ){}

    
@Post('login') //http://localhost:3000/authorization/login
async doLogin(
     @Body() data:LoginAdministratorDto,
     @Req() request:Request)
     :Promise<LoginInfoAdministratorDto|ApiResponse>{
    
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
    const jwtData=new JwtDataAdministratorDto();
    jwtData.administratorId=administrator.administratorId;
    jwtData.username=administrator.username;
    
    //da bi dosli do odredjenog tokena, trebaju nam trenutni datum i vrijeme
    let currentTime=new Date();
    currentTime.setDate(currentTime.getDate()+14); // trenutno vrijeme +14 dana
    
    //konvertujemo ga u time stamp
    const expireTimeStamp=currentTime.getTime()/1000; //da bi se dobilo u sekundama

    jwtData.exp=expireTimeStamp;
    //sledece polje je ip adresa, da bismo je uzeli, ukljucimo Request(baziran na express)
    jwtData.ip=request.ip.toString();
    jwtData.userAgent=request.headers["user-agent"];

    

    let token:string=jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const responseObject=new LoginInfoAdministratorDto(
        administrator.administratorId,
        administrator.username,
        token
    )

    return new Promise(resolve=>resolve(responseObject));
}
}

