import { Body, Controller, Get, Post, Req, UseGuards } from "@nestjs/common";
import { Request } from "express";
import { AddArticleToCartDto } from "src/dtos/cart/add.article.to.cart.dto";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { RoleCheckerGuard } from "src/misc/role.checker.file";
import { CartService } from "src/services/cart/cart.service";

@Controller('api/cart')
export class CartController{
    constructor(
        private cartService:CartService
      ){}

      private async getActiveCartForUserId(userId:number)
      {
        let cart=await this.cartService.getLatestActiveCartByUserId(userId);

        if(!cart)
        {
            cart=await this.cartService.createNewCartForUser(userId);
        }

        return await this.cartService.getById(cart.cartId);
      }

      @Get()
      @UseGuards(RoleCheckerGuard)
      @AllowToRoles('user')
      async getCurrentCart(@Req() req:Request)
      {
          const userId=req.token.id;
          this.getActiveCartForUserId(userId);
      }

      @Post('addToCart')
      @UseGuards(RoleCheckerGuard)
      @AllowToRoles('user')
      async addToCart(@Body() data:AddArticleToCartDto, @Req() req:Request)
      {
        const cart=await this.getActiveCartForUserId(req.token.id);
        return await this.cartService.addArticleToCart(data.articleId, cart.cartId, data.quantity);
      }

      
}