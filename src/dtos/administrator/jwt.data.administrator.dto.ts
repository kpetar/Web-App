export class JwtDataAdministratorDto{
    administratorId:number;
    username:string;
    ext:number; //unix time stamp
    ip:string;
    userAgent:string;

    toPlainObject(){
        return{
            administratorId:this.administratorId,
            username:this.username,
            ext:this.ext,
            ip:this.ip,
            userAgent:this.userAgent
        };
    }
}