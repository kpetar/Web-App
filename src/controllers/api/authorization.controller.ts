import { Body, Controller, HttpException, HttpStatus, Post,  Req } from "@nestjs/common";
import { LoginAdministratorDto } from "src/dtos/administrator/login.administrator.dto";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as crypto from 'crypto';
import { ApiResponse } from "src/misc/api.response.class";
import { LoginInfoDto } from "src/dtos/auth/login.info.dto";
import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";
import  {Request} from "express";
import * as jwt from 'jsonwebtoken';
import { jwtSecret } from "config/jwt.secret";
import { UserRegistrationDto } from "src/dtos/user/user.registration.dto";
import { User } from "src/entities/user.entity";
import { UserService } from "src/services/user/user.service";
import { LoginUserDto } from "src/dtos/user/login.user.dto";
import { JwtRefreshDto } from "src/dtos/auth/jwt.refresh.dto";
import { UserRefreshTokenDto } from "src/dtos/auth/user.refresh.token.dto";

@Controller('authorization/')
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
    jwtData.exp=this.getDatePlus(60*5);
    //sledece polje je ip adresa, da bismo je uzeli, ukljucimo Request(baziran na express)
    jwtData.ip=request.ip.toString();
    jwtData.userAgent=request.headers["user-agent"];

    
    //u jwtData se nalaze podaci. Da bi se formirao token na osnovu ovih podataka treba da se potpise(metoda sign())
    let token:string=jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const responseObject=new LoginInfoDto(
        administrator.administratorId,
        administrator.username,
        token,
        "",
        ""
    )

    return new Promise(resolve=>resolve(responseObject));
}

@Post('user/register') //http://localhost:3000/authorization/user/register
async userRegistration(@Body() data:UserRegistrationDto):Promise<User|ApiResponse>{
    return await this.userService.userRegistration(data);
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
    jwtData.exp=this.getDatePlus(60*1);
    //sledece polje je ip adresa, da bismo je uzeli, ukljucimo Request(baziran na express)
    jwtData.ip=request.ip.toString();
    jwtData.userAgent=request.headers["user-agent"];

    
    //u jwtData se nalaze podaci. Da bi se formirao token na osnovu ovih podataka treba da se potpise(metoda sign())
    let token:string=jwt.sign(jwtData.toPlainObject(), jwtSecret);

    const jwtRefreshData=new JwtRefreshDto();
    jwtRefreshData.id=jwtData.id;
    jwtRefreshData.role=jwtData.role;
    jwtRefreshData.identity=jwtData.identity;
    jwtRefreshData.exp=this.getDatePlus(60*60*24*31);
    jwtRefreshData.ip=jwtData.ip;
    jwtRefreshData.userAgent=jwtData.userAgent;

    let refreshToken:string=jwt.sign(jwtRefreshData.toPlainObject(), jwtSecret);

    const responseObject=new LoginInfoDto(
        user.userId,
        user.email,
        token,
        refreshToken,
        this.getIsoData(jwtRefreshData.exp)
    );

    await this.userService.addToken(
        user.userId,
        refreshToken,
        this.getDatabaseDateFormat(this.getIsoData(jwtRefreshData.exp))
    );

    return new Promise(resolve=>resolve(responseObject));
}



@Post('user/refresh')
async userTokenRefresh(@Req() req:Request, @Body() data:UserRefreshTokenDto):Promise<LoginInfoDto|ApiResponse>{
    const userToken=await this.userService.getUserToken(data.token);

    if(!userToken)
    {
        return new ApiResponse('error', -10002, 'No such refresh token!');
    }

    if(userToken.isValid===0)
    {
        return new ApiResponse('error', -10003, 'The token is no longer valid!');
    }

    const currentDate=new Date();
    const expireDate=new Date(userToken.expiresAt);

    //da li je datum isteka manji od trenutnog datuma
    if(expireDate.getTime()<currentDate.getTime())
    {
        return new ApiResponse('error', -10004, 'The token has expired!');
    } 

    //do tokena se dolazi verifikacijom

    let jwtRefreshData:JwtRefreshDto;

    try{
        jwtRefreshData=jwt.verify(data.token, jwtSecret);
    }
    catch(e)
        {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

    if(!jwtRefreshData)
    {
        throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
    }

    if(jwtRefreshData.ip!==req.ip.toString())
    {
        throw new HttpException('Bad token found',HttpStatus.UNAUTHORIZED);
    }

    if(jwtRefreshData.userAgent!==req.headers["user-agent"])
    {
        throw new HttpException('Bad token found',HttpStatus.UNAUTHORIZED);
    }

    const jwtData=new JwtDataDto();
    jwtData.role=jwtRefreshData.role;
    jwtData.id=jwtRefreshData.id;
    jwtData.identity=jwtRefreshData.identity;
    jwtData.exp=this.getDatePlus(60*5);
    jwtData.ip=jwtRefreshData.ip;
    jwtData.userAgent=jwtRefreshData.userAgent;


    let token:string=jwt.sign(jwtData.toPlainObject(),jwtSecret);

    const responseObject=new LoginInfoDto(
        jwtData.id,
        jwtData.identity,
        token,
        data.token,
        this.getIsoData(jwtData.exp)
    );

    return responseObject;
}

private getDatePlus(numbersOfSeconds:number):number
{
    return (new Date()).getTime()/1000 + numbersOfSeconds;
}

private getIsoData(timestamp:number):string 
{
    const currentDate=new Date();
    currentDate.setTime(timestamp*1000);
    return currentDate.toISOString();
}

private getDatabaseDateFormat(isoFormat:string):string{
    return isoFormat.substr(0,19).replace('T',' ');
}


}