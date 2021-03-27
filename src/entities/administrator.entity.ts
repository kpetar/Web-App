import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

//da bismo znali da je Administrator klasa moramo da je anotiramo
@Entity()

export class Administrator{
    //prvo polje u svim tabelama je primarni kljuc
    @PrimaryGeneratedColumn({
        //Preciznije definisanje kolono (citamo iz baze podataka)
        name:'administrator_id',
        type:'int',
        unsigned:true
    })
    administratorId:number;

    //sledece polje je obicna kolona
    @Column({
        type:'varchar',
        length:'32',
        unique:true
    })
    username:string;

    @Column({
        name:'password_hash',
        type:'varchar',
        length:'128',
    })
    passwordHash:string
}

