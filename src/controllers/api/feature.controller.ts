import { Controller, Get, Param, UseGuards } from "@nestjs/common";
import { Crud } from "@nestjsx/crud";
import { FeatureDistinctValuesDto } from "src/dtos/feature/feature.distinct.values";
import { Feature } from "src/entities/feature.entity";
import { AllowToRoles } from "src/misc/allow.to.roles.descriptor";
import { RoleCheckerGuard } from "src/misc/role.checker.file";
import { FeatureService } from "src/services/feature/feature.service";

@Controller('api/feature/')
@Crud({
    model:{
        type:Feature
    },
    params:{
        id:{
            field:'featureId',
            type:'number',
            primary:true
        }
    },
    query:{
        join:{
            category:{
                eager:true
            },
            articles:{
                eager:false
            },
            articleFeatures:{
                eager:false
            }
        }
    },
    routes:{
        only:[
            "createOneBase",
            "createManyBase",
            "updateOneBase",
            "getOneBase",
            "getManyBase"
        ],
        createOneBase:{
            decorators:[
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator')
            ]
        },
        createManyBase:{
            decorators:[
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator')
            ]
        },
        updateOneBase:{
            decorators:[
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator')
            ]
        },
        getOneBase:{
            decorators:[
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator','user')
            ]
        },
        getManyBase:{
            decorators:[
                UseGuards(RoleCheckerGuard),
                AllowToRoles('administrator','user')
            ]
        }
    }
})
export class FeatureController{
    constructor(
        public service:FeatureService
    ){}

    @Get('values/:categoryId')
    @UseGuards(RoleCheckerGuard)
    @AllowToRoles('administrator', 'user')
    async getDistinctValuesByCategoryId(@Param('categoryId') categoryId:number):Promise<FeatureDistinctValuesDto>
    {
        return await this.service.getDistinctValuesByCategoryId(categoryId);
    }
}
