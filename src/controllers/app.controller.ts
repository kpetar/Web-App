import { Body, Controller, Get, Put } from '@nestjs/common';
import { AddAdministratorDto } from 'src/dtos/administrator/add.administrator.dto';
import { Administrator } from '../../entities/administrator.entity';
import { User } from '../../entities/user.entity';
import { AdministratorService } from '../services/administrator/administrator.service';

@Controller()
export class AppController {
  //da bi mogli pozvati servis, mora biti ukljucen u kontroler. Da bismo ga ukljucili uradicemo sledece
  constructor(
    private administratorService:AdministratorService
  ){}
  //u spisku parametara definisemo da treba da ukljuci jedan privatni podatak koji cemo nazvati adm..S
  //i tip tog podatka je AdministratorService
  //Sada mozemo u getAllAdmins() 

  @Get()
  getIndex(): string {
    return 'Home Page!';
  }

}
