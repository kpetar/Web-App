import * as Validator from 'class-validator';

export class AddArticleToCartDto{
    articleId:number;
    
    @Validator.IsNotEmpty()
    quantity: number;
}