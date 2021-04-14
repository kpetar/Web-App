import * as Validator from 'class-validator';
import { AddArticleFeaturesDto } from './add.article.features.dto';

export class EditArticleDto{
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
    @Validator.IsString()
    @Validator.IsIn(["available","visible","hidden"])
    status: "available" | "visible" | "hidden";

    @Validator.IsNotEmpty()
    @Validator.IsIn([0,1])
    isPromoted: number;
    
    @Validator.IsNotEmpty()
    @Validator.IsPositive()
    @Validator.IsNumber({
    allowInfinity:false,
    allowNaN:false,
    maxDecimalPlaces:2
     })
    price: number;

    @Validator.IsOptional()
    @Validator.IsArray()
    @Validator.ValidateNested({
        always:true
    })
    features:AddArticleFeaturesDto[] |null;
}