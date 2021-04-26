export class JwtRefreshDto{
    id:number;
    role:"administrator"|"user";
    identity:string;
    exp:number; //unix time stamp
    ip:string;
    userAgent:string;

    toPlainObject(){
        return{
            id:this.id,
            role:this.role,
            identity:this.identity,
            ext:this.exp,
            ip:this.ip,
            userAgent:this.userAgent
        };
    }
}