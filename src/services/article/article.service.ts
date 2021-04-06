import { Inject, Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Article } from "src/entities/article-entity";
import { ArticleFeature } from "src/entities/article-feature.entity";
import { ArticlePrice } from "src/entities/article-price.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { Repository } from "typeorm";

@Injectable()
export class ArticleService extends TypeOrmCrudService<Article>{
    constructor(
        @InjectRepository(Article)
        private readonly article:Repository<Article>,

        @InjectRepository(ArticlePrice)
        private readonly articlePrice:Repository<ArticlePrice>,

        @InjectRepository(ArticleFeature)
        private readonly articleFeature:Repository<ArticleFeature>
    )
    {
        super(article);
    }

    async getFullArticle(data:AddArticleDto):Promise<Article>{

        let newArticle=new Article();

        newArticle.name         =   data.name;
        newArticle.categoryId   =   data.categoryId;
        newArticle.excerpt      =   data.excerpt;
        newArticle.description  =   data.description;   

        let savedArticle=await this.article.save(newArticle);

        let newArticlePrice=new ArticlePrice();

        newArticlePrice.articleId   =   savedArticle.articleId;
        newArticlePrice.price       =   data.price;

        await this.articlePrice.save(newArticlePrice);


        for(let feature of data.features)
        {
            let newArticleFeature=new ArticleFeature();
            newArticleFeature.articleId =   savedArticle.articleId;
            newArticleFeature.featureId =   feature.featureId;
            newArticleFeature.value     =   feature.value;

            await this.articleFeature.save(newArticleFeature);
        }

        return await this.article.findOne(savedArticle.articleId,{
            relations:[
                "category",
                "articleFeatures",
                "features",
                "articlePrices"
            ]
        })
}}