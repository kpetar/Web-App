import * as Validator from 'class-validator';
import { AddArticleFeaturesDto } from './add.article.features.dto';

export class SearchArticleDto{
    
    @Validator.IsNotEmpty()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity:false,
        allowNaN:false,
        maxDecimalPlaces:0
    })
    categoryId:number;
    
    @Validator.IsOptional()
    @Validator.IsString()
    @Validator.Length(0,128)
    keywords:string;

    @Validator.IsOptional()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity:false,
        allowNaN:false,
        maxDecimalPlaces:2
    })
    minPrice:number;
    
    @Validator.IsOptional()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity:false,
        allowNaN:false,
        maxDecimalPlaces:2
    })
    maxPrice:number;
    
    @Validator.IsOptional()
    @Validator.IsArray()
    @Validator.ValidateNested({
        always:true
    })
    features:AddArticleFeaturesDto[]

    @Validator.IsOptional()
    @Validator.IsIn(["name","price"])
    orderBy:"name"|"price";

    @Validator.IsOptional()
    @Validator.IsIn(["ASC","DESC"])
    orderDirection:"ASC"|"DESC";

    @Validator.IsOptional()
    @Validator.IsPositive()
    @Validator.IsNumber({
        allowInfinity:false,
        allowNaN:false,
        maxDecimalPlaces:0
    })
    page:number;

    @Validator.IsOptional()
    @Validator.IsIn([5,10,15,20,25])
    itemsPerPage:5|10|15|20|25;

}