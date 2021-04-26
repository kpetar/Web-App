export class LoginInfoDto{
    id:number;
    identity:string;
    token:string;
    refreshToken:string;
    refreshTokenExpiredAt:string;

    constructor(id:number, identity:string, jwt:string, refreshToken:string, refreshTokenExpiredAt:string)
    {
        this.id=id;
        this.identity=identity;
        this.token=jwt;
        this.refreshToken=refreshToken;
        this.refreshTokenExpiredAt=refreshTokenExpiredAt;
    }
}