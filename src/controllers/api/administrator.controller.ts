import { Body, Controller, Get, Param, Post, Put } from "@nestjs/common";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { EditAdministratorDto } from "src/dtos/administrator/edit.administrator.dto";
import { Administrator } from "src/entities/administrator.entity";
import { ApiResponse } from "src/misc/api.response.class";
import { AdministratorService } from "src/services/administrator/administrator.service";

@Controller('api/administrator')
export class AdministratorController{
    constructor(
        private administratorService:AdministratorService
      ){}
    

  @Get()
  //vraca isto sto i servis. Vraca obecanje da ce vratiti niz administratora
  getAllAdmins():Promise<Administrator[]>{
    return this.administratorService.getAll();
  }

  //Get jednog admina, koji ce zahtjeva prosledjivanje jednog parametra
  @Get(':id')
  getById(@Param('id') administratorId:number):Promise<Administrator|ApiResponse>{
    return this.administratorService.getById(administratorId);
  }

  @Put()
  add(@Body() data:AddAdministratorDto):Promise<Administrator|ApiResponse>{
    return this.administratorService.add(data);
  }

  @Post(':id')
  edit(@Param('id') id:number, @Body() data:EditAdministratorDto):Promise<Administrator|ApiResponse>{
    return this.administratorService.editById(id, data);
  }
}