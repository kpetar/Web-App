import { Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { FeatureDistinctValuesDto } from "src/dtos/feature/feature.distinct.values";
import { ArticleFeature } from "src/entities/article-feature.entity";
import { Feature } from "src/entities/feature.entity";
import { Repository } from "typeorm";

@Injectable()
export class FeatureService extends TypeOrmCrudService<Feature>{
    constructor(
        @InjectRepository(Feature) private readonly feature:Repository<Feature>,
        @InjectRepository(ArticleFeature) private readonly articleFeature:Repository<ArticleFeature>
    ){
        super(feature);
    }

    async getDistinctValuesByCategoryId(categoryId:number):Promise<FeatureDistinctValuesDto>
    {
        const features = await this.feature.find({categoryId:categoryId});

        const featureResults:FeatureDistinctValuesDto={
            features:[]
        };

        if(!features || features.length===0)
        {
            return featureResults;
        }

        featureResults.features=await Promise.all(features.map(async feature=>{
            
            const values:string[]=(
                                    await this.articleFeature.createQueryBuilder("af")
                                    .select("DISTINCT af.value",'value')
                                    .where('af.featureId=:featureId',{ featureId:feature.featureId})
                                    .orderBy('af.value', 'ASC')
                                    .getRawMany())
                                    .map(item=>item.value);
            
            return{
                featureId:feature.featureId,
                name:feature.name,
                values:values
            };
        }));

        return featureResults;

    }
}