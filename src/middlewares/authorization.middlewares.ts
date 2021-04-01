import { HttpException, HttpStatus, Injectable, NestMiddleware } from "@nestjs/common";
import { NextFunction, Request, Response } from "express";
import { AdministratorService } from "src/services/administrator/administrator.service";
import * as jwt from 'jsonwebtoken';
import { JwtDataAdministratorDto } from "src/dtos/administrator/jwt.data.administrator.dto";
import { jwtSecret } from "config/jwt.secret";

@Injectable()
export class AuthorizationMiddleware implements NestMiddleware{

    constructor(
        private readonly administratorService:AdministratorService
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
        const jwtData:JwtDataAdministratorDto=jwt.verify(tokenString, jwtSecret);

        //u slucaju da deserijalizacija ne prodje kako treba
        if(!jwtData)
        {
            throw new HttpException('Bad token found', HttpStatus.UNAUTHORIZED);
        }

        const ip=req.ip.toString();
        if(jwtData.ip!==ip)
        {
            throw new HttpException('Bad token found',HttpStatus.UNAUTHORIZED);
        }

        if(jwtData.userAgent!==req.headers["user-agent"])
        {
            throw new HttpException('Bad token found',HttpStatus.UNAUTHORIZED);
        }

        //sada provjeravamo da li administrator postoji
        const administrator=await this.administratorService.getById(jwtData.administratorId);
        if(!administrator)
        {
            throw new HttpException('Account does not exist',HttpStatus.UNAUTHORIZED);
        }

        //sada provjeravamo da li je token istekao
        let currentTime=new Date();
        const currentTimeStamp=new Date().getTime()/1000;
        if(currentTimeStamp>=jwtData.ext)
        {
            throw new HttpException('Token has expired',HttpStatus.UNAUTHORIZED);

        }


        next();
    }
    
}