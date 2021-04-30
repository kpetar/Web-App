import { HttpException, HttpStatus, Injectable, NestMiddleware } from "@nestjs/common";
import { NextFunction, Request, Response } from "express";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as jwt from 'jsonwebtoken';
import { JwtDataDto } from "src/dtos/auth/jwt.data.dto";
import { jwtSecret } from "config/jwt.secret";
import { UserService } from "src/services/user/user.service";

@Injectable()
export class AuthorizationMiddleware implements NestMiddleware{

    constructor(
        public readonly administratorService:AdministratorService,
        public readonly userService:UserService
    ){}

    async use(req: Request, res: Response, next: NextFunction) {
        
        if(!req.headers.authorization)
        {
            throw new HttpException('Token not found', HttpStatus.UNAUTHORIZED);
        }

        //izvuci token
        const token=req.headers.authorization;

        const tokenParts=token.split(' ');
        if(tokenParts.length!==2)
        {
            throw new HttpException('Token not found', HttpStatus.UNAUTHORIZED);
        }
        const tokenString=tokenParts[1];

        //formiraj jwt objekat
        let jwtData:JwtDataDto;

        try{
        jwtData=jwt.verify(tokenString, jwtSecret);
        }catch(e)
        {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }
        //u slucaju da deserijalizacija ne prodje kako treba
        if(!jwtData)
        {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        if(jwtData.ip!==req.ip.toString())
        {
            throw new HttpException('Bad token found',HttpStatus.UNAUTHORIZED);
        }

        if(jwtData.userAgent!==req.headers["user-agent"])
        {
            throw new HttpException('Bad token found',HttpStatus.UNAUTHORIZED);
        }

        //sada provjeravamo da li administrator postoji
        if(jwtData.role==="administrator"){
            const administrator=await this.administratorService.getById(jwtData.id);
            if(!administrator)
            {
                throw new HttpException('Account does not exist',HttpStatus.UNAUTHORIZED);
            }
        }
        else if(jwtData.role==="user")
        {
            const user=await this.userService.getById(jwtData.id);
            if(!user)
            {
                throw new HttpException('Account does not exist',HttpStatus.UNAUTHORIZED);
            }
        }
        //sada provjeravamo da li je token istekao
        const currentTimeStamp=new Date().getTime()/1000;
        if(currentTimeStamp>=jwtData.exp)
        {
            throw new HttpException('Token has expired',HttpStatus.UNAUTHORIZED);

        }

        req.token=jwtData;

        next();
    }
    
}