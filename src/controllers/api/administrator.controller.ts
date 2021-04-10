import { Body, Controller, Get, Param, Patch, Post, Put, UseGuards } from "@nestjs/common";
import { AddAdministratorDto } from "src/dtos/administrator/add.administrator.dto";
import { EditAdministratorDto } from "src/dtos/administrator/edit.administrator.dto";
import { Administrator } from "src/entities/administrator.entity";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckerGuard } from "src/misc/role.checker.file";
import { AdministratorService } from "src/services/administrator/administrator.service";

@Controller('api/administrator')
export class AdministratorController{
    constructor(
        private administratorService:AdministratorService
      ){}
    

  @Get()
  @UseGuards(RoleCheckerGuard)
  @AllowToRoles('administrator')
  //vraca isto sto i servis. Vraca obecanje da ce vratiti niz administratora
  getAllAdmins():Promise<Administrator[]>{
    return this.administratorService.getAll();
  }

  //Get jednog admina, koji ce zahtjeva prosledjivanje jednog parametra
  @Get(':id')
  @UseGuards(RoleCheckerGuard)
  @AllowToRoles('administrator')
  getById(@Param('id') administratorId:number):Promise<Administrator|ApiResponse>{
    return this.administratorService.getById(administratorId);
  }

  @Post()
  @UseGuards(RoleCheckerGuard)
  @AllowToRoles('administrator')
  add(@Body() data:AddAdministratorDto):Promise<Administrator|ApiResponse>{
    return this.administratorService.add(data);
  }

  @Patch(':id')
  @UseGuards(RoleCheckerGuard)
  @AllowToRoles('administrator')
  edit(@Param('id') id:number, @Body() data:EditAdministratorDto):Promise<Administrator|ApiResponse>{
    return this.administratorService.editById(id, data);
  }
}