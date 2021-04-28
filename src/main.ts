import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { NestExpressApplication } from '@nestjs/platform-express';
import { StorageConfiguration } from 'config/storage.configuration';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);

  app.useStaticAssets(StorageConfiguration.photo.destination,{
    prefix:StorageConfiguration.photo.urlPrefix,
    maxAge:StorageConfiguration.photo.maxAge,
    index:false
  })

  app.useGlobalPipes(new ValidationPipe({

  }));

  app.enableCors();

  await app.listen(3000);
}
bootstrap();
