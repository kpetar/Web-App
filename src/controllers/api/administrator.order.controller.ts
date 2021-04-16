import { Body, Controller, Get, Param, Patch, UseGuards } from "@nestjs/common";
import { ChangeOrderStatusDto } from "src/dtos/order/change.order.status.dto";
import { Order } from "src/entities/order.entity";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { ApiResponse } from "src/misc/api.response.class";
import { RoleCheckerGuard } from "src/misc/role.checker.file";
import { OrderService } from "src/services/order/order.service";

@Controller('api/order')
export class AdministratorOrderController{
    constructor(
        private orderService:OrderService
    ){}

    @Get(':id')
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')
    async getOrder(@Param('id') orderId:number):Promise<Order|ApiResponse>
    {
        const order=await this.orderService.getById(orderId);
        if(!order)
        {
           return new ApiResponse('error',-9001,"Order not found!");
        }
        return order;
    }

    @Patch(':id')
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator')
    async changeStatus(@Param('id') orderId:number, @Body() data:ChangeOrderStatusDto):Promise<Order|ApiResponse>
    {
        
        return await this.orderService.changeStatus(orderId, data);
    }
}