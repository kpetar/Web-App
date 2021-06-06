import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { ChangeOrderStatusDto } from "src/dtos/order/change.order.status.dto";
import { Cart } from "src/entities/cart.entity";
import { Order } from "src/entities/order.entity";
import { ApiResponse } from "src/misc/api.response.class";
import { Repository } from "typeorm";

@Injectable()
export class OrderService{
    constructor(
        @InjectRepository(Order) private readonly order:Repository<Order>,
        @InjectRepository(Cart) private readonly cart:Repository<Cart>
        ){}

    async add(cartId:number):Promise<Order|ApiResponse>
    {
        const order=await this.order.findOne({
            cartId:cartId
        });

        if(order)
        {
            return new ApiResponse('error', -7001, "An order for this cart has already been made!");
        }

        const cart:Cart=await this.cart.findOne(cartId,{
            relations:[
                "cartArticles"
            ]
        });
        if(!cart)
        {
            return new ApiResponse('error',-7002,'No cart found!');
        }

        if(cart.cartArticles.length===0)
        {
            return new ApiResponse('error',-7003, 'This cart is empty');
        }
        
        const newOrder:Order=new Order();
        newOrder.cartId=cartId;
        newOrder.userId=cart.userId;
        const savedOrder=await this.order.save(newOrder);


        cart.createdAt=new Date();
        await this.cart.save(cart);

        return await this.getById(savedOrder.orderId);


    }

    async getById(orderId:number)
    {
        return await this.order.findOne(orderId,{
            relations:[
                "cart",
                "cart.user",
                "cart.cartArticles",
                "cart.cartArticles.article",
                "cart.cartArticles.article.category",
                "cart.cartArticles.article.articlePrices"
            ]
        });
    }

    async getAllByUserId(userId:number):Promise<Order[]>
    {
        return await this.order.find({
            where:{
                userId:userId
            },
            relations:[
                "cart",
                "cart.user",
                "cart.cartArticles",
                "cart.cartArticles.article",
                "cart.cartArticles.article.category",
                "cart.cartArticles.article.articlePrices"
            ]
        });
    }

    async getAll()
    {
        return await this.order.find({
            relations:[
                "cart",
                "cart.user",
                "cart.cartArticles",
                "cart.cartArticles.article",
                "cart.cartArticles.article.category",
                "cart.cartArticles.article.articlePrices"
            ]
        })
    }

    async changeStatus(orderId:number, data:ChangeOrderStatusDto):Promise<Order|ApiResponse>
    {
        const order=await this.getById(orderId);
        if(!order)
        {
            return new ApiResponse('error', -9001, "Order not found!");
        }

        order.status=data.newStatus;

        await this.order.save(order);

        return await this.getById(orderId);
    }

}