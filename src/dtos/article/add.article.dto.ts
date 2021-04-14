import * as Validator from 'class-validator';
import { AddArticleFeaturesDto } from './add.article.features.dto';

export class AddArticleDto{
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(5,32)
    name: string;

    categoryId:number;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(1,32)
    excerpt: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(64,10000)
    description: string;
   
    @Validator.IsNotEmpty()
    @Validator.IsPositive()
    @Validator.IsNumber({
    allowInfinity:false,
    allowNaN:false,
    maxDecimalPlaces:2
    })
    price:number;

    @Validator.IsArray()
    @Validator.ValidateNested({
        always:true
    })
    features:AddArticleFeaturesDto[]
}