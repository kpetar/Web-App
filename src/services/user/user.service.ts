import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
    constructor(
        @InjectRepository(User) private readonly user:Repository<User>
    ){}

    getAll():Promise<User[]>
    {
        return this.user.find();
    }

    getById(id:number):Promise<User>
    {
        return this.user.findOne(id);
    }
}
