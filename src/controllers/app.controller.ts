import { Controller, Get} from '@nestjs/common';
import { AdministratorService } from '../services/administrator/administrator.service';

@Controller()
export class AppController {
  
  @Get()
  getIndex(): string {
    return 'Home Page!';
  }

}
