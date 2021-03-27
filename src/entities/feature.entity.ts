import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { ArticleFeature } from "./article-feature.entity";
import { Category } from "./category.entity";

@Index("fk_feature_category_id", ["categoryId"], {})
@Index("uq_feature_name_category_id", ["name", "categoryId"], { unique: true })
@Entity()
export class Feature {
  @PrimaryGeneratedColumn({ type: "int", name: "feature_id", unsigned: true })
  featureId: number;

  @Column({type:"varchar", length: 32 })
  name: string;

  @Column({type:"int", name: "category_id", unsigned: true })
  categoryId: number;

  @OneToMany(() => ArticleFeature, (articleFeature) => articleFeature.feature)
  articleFeatures: ArticleFeature[];

  @ManyToOne(() => Category, (category) => category.features, {
    onDelete: "NO ACTION",
    onUpdate: "CASCADE",
  })
  @JoinColumn([{ name: "category_id", referencedColumnName: "categoryId" }])
  category: Category;
}
