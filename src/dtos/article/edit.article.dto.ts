export class EditArticleDto{
    name:string;
    categoryId:number;
    excerpt:string;
    description:string;
    status: 'available'|'visible'|'hidden';
    isPromoted:1;
    price:number;
    features:{
        featureId:number;
        value:string;
    }[]|null;
}