//
//  TargetModel.m
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "TargetModel.h"
#import "TargetPhaseModel.h"


@implementation TargetModel



+ (NSDictionary *)objectClassInArray{
    return @{
             @"phaseAry" : @"TargetPhaseModel",
            
             };
}


+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"targetName" : @"title",
            @"phaseAry" : @"stage"
             };
}






-(NSString*)description{
    
    return [NSString stringWithFormat:@"<%@: %p>\n{\n   Id:%d,\n   targetName:%@,\n   phaseTableName:%@,\n   beginDate:%@\n}",[self class],self,self.ID,self.targetName,self.phaseTableName,self.beginDate];
}



////返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"targetName" : @"name",
//             @"phaseAry":@"value"
//             };
//}
//
//
//// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"phaseAry" : [TargetPhaseModel class],
//             };
//}



@end
