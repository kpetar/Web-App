import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './controllers/app.controller';
import { DatabaseConfiguration } from '../config/database.configuration';
import { Administrator } from '../entities/administrator.entity';
import { Article } from '../entities/article-entity';
import { ArticleFeature } from '../entities/article-feature.entity';
import { ArticlePrice } from '../entities/article-price.entity';
import { CartArticle } from '../entities/cart-article.entity';
import { Cart } from '../entities/cart.entity';
import { Category } from '../entities/category.entity';
import { Feature } from '../entities/feature.entity';
import { Order } from '../entities/order.entity';
import { Photo } from '../entities/photo.entity';
import { User } from '../entities/user.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { AdministratorController } from './controllers/api/administrator.controller';
import { CategoryController } from './controllers/api/category.controller';
import { CategoryService } from './services/category/category.service';
import { ArticleController } from './controllers/api/article.controller';
import { ArticleService } from './services/article/article.service';
import { AuthorizationController } from './controllers/api/authorization.controller';
import { AuthorizationMiddleware } from './middlewares/authorization.middlewares';



@Module({
  //glavni modul treba da izvrsi povezivanje sa mysql-om pomocu imports komponente
  //imports- navodi spisak svih modula koje ovaj nas modul importuje
  //koristimo modul za povezivanje na typeorm bazu podataka
  imports: [
    TypeOrmModule.forRoot({
      type:'mysql',
      host:DatabaseConfiguration.hostname,
      port:3306,
      username:DatabaseConfiguration.username,
      password:DatabaseConfiguration.password,
      database:DatabaseConfiguration.database,
      //typeormModul omogucava rad sa entitetima, dakle sa nekim tabelama
      //Za svaku od tabela moramo napraviti po jedan entitet, pa ih negdje moramo navesti
      entities:[
        Administrator,
        Article,
        ArticleFeature,
        ArticlePrice,
        CartArticle,
        Cart,
        Category,
        Feature,
        Order,
        Photo,
        User
      ]
    }),
    //Kada je napravljen entitet Administrator, takodje mora biti i nabrojan
    //kao jedan od dostupnih typeorm modula sa kojima ce raditi glavna aplikacija
    TypeOrmModule.forFeature([
      Administrator,
      Category,
      Article,
      ArticlePrice,
      ArticleFeature
    ])
    //ovoj f-ji prosledjujemo spisak svih entiteta za koje treba automatski da napravi repozitorijume
  ],
  controllers: [AppController, AdministratorController, CategoryController, ArticleController, 
  AuthorizationController],
  providers: [AdministratorService, CategoryService, ArticleService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    //consumer primjenjuje odredjeni middleware
    consumer
    .apply(AuthorizationMiddleware)
    .exclude('auth/*')
    .forRoutes('api/*');
  }

}
