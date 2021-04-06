export class JwtDataAdministratorDto{
    administratorId:number;
    username:string;
    exp:number; //unix time stamp
    ip:string;
    userAgent:string;

    toPlainObject(){
        return{
            administratorId:this.administratorId,
            username:this.username,
            ext:this.exp,
            ip:this.ip,
            userAgent:this.userAgent
        };
    }
}