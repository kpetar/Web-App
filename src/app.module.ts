import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './controllers/app.controller';
import { DatabaseConfiguration } from '../config/database.configuration';
import { Administrator } from '../src/entities/administrator.entity';
import { Article } from '../src/entities/article-entity';
import { ArticleFeature } from '../src/entities/article-feature.entity';
import { ArticlePrice } from '../src/entities/article-price.entity';
import { CartArticle } from '../src/entities/cart-article.entity';
import { Cart } from '../src/entities/cart.entity';
import { Category } from '../src/entities/category.entity';
import { Feature } from '../src/entities/feature.entity';
import { Order } from '../src/entities/order.entity';
import { Photo } from '../src/entities/photo.entity';
import { User } from '../src/entities/user.entity';
import { AdministratorService } from './services/administrator/administrator.service';
import { AdministratorController } from './controllers/api/administrator.controller';
import { CategoryController } from './controllers/api/category.controller';
import { CategoryService } from './services/category/category.service';
import { ArticleController } from './controllers/api/article.controller';
import { ArticleService } from './services/article/article.service';
import { AuthorizationController } from './controllers/api/authorization.controller';
import { AuthorizationMiddleware } from './middlewares/authorization.middlewares';
import { PhotoService } from './services/photo/photo.services';
import { FeatureService } from './services/feature/feature.service';
import { FeatureController } from './controllers/api/feature.controller';
import { UserService } from './services/user/user.service';
import { CartController } from './controllers/api/user.cart.controller';
import { CartService } from './services/cart/cart.service';
import { OrderService } from './services/order/order.service';
import { AdministratorOrderController } from './controllers/api/administrator.order.controller';
import { UserToken } from './entities/user-token.entity';
import { AdministratorToken } from './entities/administrator-token.entity';



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
        User,
        UserToken,
        AdministratorToken
      ]
    }),
    //Kada je napravljen entitet Administrator, takodje mora biti i nabrojan
    //kao jedan od dostupnih typeorm modula sa kojima ce raditi glavna aplikacija
    TypeOrmModule.forFeature([
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
        User,
        UserToken,
        AdministratorToken
    ])
    //ovoj f-ji prosledjujemo spisak svih entiteta za koje treba automatski da napravi repozitorijume
  ],
  controllers: [AppController, AdministratorController, CategoryController, ArticleController, 
  AuthorizationController, FeatureController, CartController, AdministratorOrderController],
  providers: [AdministratorService, CategoryService, ArticleService, PhotoService, FeatureService, UserService, CartService, OrderService],
  exports:[AdministratorService, UserService]
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    //consumer primjenjuje odredjeni middleware
    consumer
    .apply(AuthorizationMiddleware)
    .exclude('authorization/*')
    .forRoutes('api/*');
  }

}
