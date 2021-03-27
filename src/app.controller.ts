import { Controller, Get } from '@nestjs/common';
import { Administrator } from './entities/administrator.entity';
import { User } from './entities/user.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { UserService } from './services/user/user.service';

@Controller()
export class AppController {
  

  @Get()
  getIndex(): string {
    return 'Home Page!';
  }

  @Get('api/administrator')
  //vraca isto sto i servis. Vraca obecanje da ce vratiti niz administratora
  getAllAdmins():Promise<Administrator[]>{
    return this.administratorService.getAll();
  }

  @Get('api/user')

  getAllUsers():Promise<User[]>{
    return this.userService.getAll();
  }

  //da bi mogli pozvati servis, mora biti ukljucen u kontroler. Da bismo ga ukljucili uradicemo sledece
  constructor(
    private administratorService:AdministratorService,
    private userService:UserService
  ){}
  //u spisku parametara definisemo da treba da ukljuci jedan privatni podatak koji cemo nazvati adm..S
  //i tip tog podatka je AdministratorService
  //Sada mozemo u getAllAdmins() 



}
