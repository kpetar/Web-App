import { Inject, Injectable } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { TypeOrmCrudService } from "@nestjsx/crud-typeorm";
import { Article } from "src/entities/article-entity";
import { ArticleFeature } from "src/entities/article-feature.entity";
import { ArticlePrice } from "src/entities/article-price.entity";
import { AddArticleDto } from "src/dtos/article/add.article.dto";
import { In, Repository } from "typeorm";
import { EditArticleDto } from "src/dtos/article/edit.article.dto";
import { ApiResponse } from "src/misc/api.response.class";
import { SearchArticleDto } from "src/dtos/article/search.article.dto";

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

    async createFullArticle(data:AddArticleDto):Promise<Article|ApiResponse>{

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
        return new Promise(async(resolve)=>{
            await this.article.findOne(savedArticle.articleId,{
                relations:[
                    "category",
                    "articleFeatures",
                    "features",
                    "articlePrices"
                ]
            })
            .then(result=>resolve(result))
            .catch(()=>{
                resolve(new ApiResponse('error',-1003))
            })
        })

    }

    async editFullArticle(articleId:number, data:EditArticleDto):Promise<Article|ApiResponse>
    {
        //postojeci artikal
        const existingArticle:Article=await this.article.findOne(articleId,{
            relations:[
                'articlePrices',
                'articleFeatures'
            ]
        });

        if(!existingArticle)
        {
            return new ApiResponse('error',-5001,'Article not found');
        }

        existingArticle.name=data.name;
        existingArticle.categoryId=data.categoryId;
        existingArticle.excerpt=data.excerpt;
        existingArticle.description=data.description;
        existingArticle.status=data.status;
        existingArticle.isPromoted=data.isPromoted;

        //cuvanje u bazi podataka
        const savedArticle=await this.article.save(existingArticle);

        //ukoliko dodje do neke greske prilikom editovanja
        if(!savedArticle)
        {
            return new ApiResponse('error',-5002,'Could not save new article data');
        }

        //Sto se tice cijene, necemo je dodavati svaki put iskljucivo kada je ista
        //trebaju nam informacije o staroj cijeni u obliku string-a i o poslednjoj cijeni
        const newPriceString:string=Number(data.price).toFixed(2); //pretvara se na fiksni broj decimalnih mjesta na dvije decimale 10-'10.00'

        const lastPrice=existingArticle.articlePrices[existingArticle.articlePrices.length-1].price;

        const lastPriceString:string=Number(lastPrice).toFixed(2);

        if(newPriceString!==lastPriceString)
        {
            const newArticlePrice=new ArticlePrice();

            newArticlePrice.articleId=articleId;
            newArticlePrice.price=data.price;

            const savedArticlePrice=await this.articlePrice.save(newArticlePrice);
            if(!newArticlePrice)
            {
                return new ApiResponse('error',-5003,'Could not save the new article price');
            
            }
        }

        if(data.features!==null)
            {
                await this.articleFeature.remove(existingArticle.articleFeatures);

                for(let feature of data.features)
                {
                    let newArticleFeature=new ArticleFeature();
                    newArticleFeature.articleId =   articleId;
                    newArticleFeature.featureId =   feature.featureId;
                    newArticleFeature.value     =   feature.value;

                    await this.articleFeature.save(newArticleFeature);
                }
            }
            return await this.article.findOne(articleId,{
                relations:[
                    "category",
                    "articleFeatures",
                    "features",
                    "articlePrices"
                ]
            });



     }

     async searchArticle(data:SearchArticleDto):Promise<Article[]|ApiResponse>
     {
        const builder=await this.article.createQueryBuilder("article");

        builder.innerJoinAndSelect("article.articlePrices", "ap");
        builder.leftJoin("article.articleFeatures", "af", 
        "ap.createdAt=(SELECT MAX(ap.created_at) FROM article_price AS ap WHERE ap.article_id=article.article_id)"
        );

        builder.where('article.categoryId=:categoryId',{
            categoryId:data.categoryId
        });

        //Ako postoji keywords i ukoliko im je duzina veca od 0
        if(data.keywords && data.keywords.length>0)
        {
            builder.andWhere(
            '(article.name LIKE :kw OR article.excerpt LIKE :kw OR article.description LIKE :kw)', {
                kw:'%' + data.keywords + '%'
            });
        }

        //Ukoliko postoji vrijednost minPrice
        if(data.minPrice && typeof data.minPrice==='number')
        {
            builder.andWhere('ap.price>=:min', {
                min:data.minPrice
            })
        }

        //Ukolko postoji vrijednost maxPrice
        if(data.maxPrice && typeof data.maxPrice==='number')
        {
            builder.andWhere('ap.price<=:max',{
                max:data.maxPrice
            })
        }

        //IN - jedna vrijednost iz niza string-ova
        if(data.features && data.features.length>0)
        {
            for(const feature of data.features)
            {
                builder.andWhere('af.featureId=:fId AND af.value IN (:fValues)',{
                    fId:feature.featureId,
                    fValues:feature.value
                });
            }
        }

        //Pretpostavka da je orderBy='name' i orderDirection='ASC'
        let orderBy='article.name';
        let orderDirection:"ASC"|"DESC"="ASC";

        if(data.orderBy)
        {
            orderBy=data.orderBy;
            if(orderBy==='name')
            {
                orderBy='article.name';
            }
            if(orderBy==='price')
            {
                orderBy='ap.price';
            }
        }
        if(data.orderDirection)
        {
            orderDirection=data.orderDirection;
        }
        builder.orderBy(orderBy, orderDirection);

        let page=0;
        let itemsPerPage=5|10|15|20|25;

        if(data.page && typeof data.page==='number')
        {
            page=data.page;
        }
        if(data.itemsPerPage && typeof data.itemsPerPage==='number')
        {
            itemsPerPage=data.itemsPerPage;
        }
        builder.skip(page*itemsPerPage);
        builder.take(itemsPerPage);

        //Uzeti odredjene items-e 
        let articleIds=await (await builder.getMany()).map(article=>article.articleId);


        if(articleIds.length===0)
        {
            return new ApiResponse("ok", 0, "No articles found!");
        }

        return await this.article.find({
            where:{
                articleId:In(articleIds)
            },
            relations:[ 
                "category",
                "articleFeatures",
                "features",
                "articlePrices"
            ]
        })
        

     }
    

        

    }
