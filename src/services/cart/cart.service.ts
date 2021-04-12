import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { CartArticle } from "src/entities/cart-article.entity";
import { Cart } from "src/entities/cart.entity";
import { Repository } from "typeorm";

@Injectable()
export class CartService{
    constructor(@InjectRepository(Cart) private readonly cart:Repository<Cart>,
                @InjectRepository(CartArticle) private readonly cartArticle:Repository<CartArticle>
        
                ){}
    
    async getLatestActiveCartByUserId(userId:number)
    {
        const carts=await this.cart.find({
            where:{
                userId:userId
            },
            order:{
                createdAt:"DESC",
            },
            take:1,
            relations:[
                "order"
            ]
        })

        if(!carts || carts.length===0)
        {
            return null;
        }

        const cart=carts[0];
        if(cart.order!==null)
        {
            return null;
        }

        return cart;
    }

    async createNewCartForUser(userId:number)
    {
        const newCart:Cart=new Cart();
        newCart.userId=userId;
        return await this.cart.save(newCart);
    }

    async addArticleToCart(articleId:number, cartId:number, quantity:number)
    {
        let record:CartArticle=await this.cartArticle.findOne({
            cartId:cartId,
            articleId:articleId
        })

        if(!record)
        {
            record=new CartArticle();
            record.cartId=cartId;
            record.articleId=articleId;
            record.quantity=quantity;
        }
        else
        {
            record.quantity+=quantity;
        }
        return await this.cartArticle.save(record);
    }

    async getById(cartId:number)
    {
        return await this.cart.findOne(cartId,{
            relations:[
                "user",
                "cartArticles",
                "cartArticles.article",
                "cartArticles.article.category"
            ]
        });
    }

    async changeQuantity(cartId:number, articleId:number, newQuantity:number)
    {
        let record:CartArticle=await this.cartArticle.findOne({
            cartId:cartId,
            articleId:articleId
        })

        if(record)
        {
            record.quantity=newQuantity;
            if(record.quantity===0)
            {
                await this.cartArticle.delete(record.cartArticleId);
            }
            else
            {
                await this.cartArticle.save(record);
            }
        }

        return await this.getById(cartId);
    }
}