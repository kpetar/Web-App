import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";


@Entity()

export class User{
    @PrimaryGeneratedColumn({
        name:'user_id',
        type:'int'
    })
    userId:number;

    @Column({
        type:'varchar',
        length:'255',
        unique:true
    })
    email:string;

    @Column({
        name:'password_hash',
        type:'varchar',
        length:'128'
    })
    passwordHash:string;

    @Column({
        type:'varchar',
        length:'64'
    })
    forename:string;

    @Column({
        type:'varchar',
        length:'64'
    })
    surname:string;

    @Column({
        name:'phone_number',
        type:'varchar',
        length:'24',
        unique:true
    })
    phoneNumber:string;

    @Column({
        name:'postal_address',
        type:'text'
    })
    postalAddress:string;
}