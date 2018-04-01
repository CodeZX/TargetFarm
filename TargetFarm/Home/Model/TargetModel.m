//
//  TargetModel.m
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "TargetModel.h"
#import "TargetScheduleModel.h"

@implementation TargetModel





-(NSString*)description{
    
    return [NSString stringWithFormat:@"<%@: %p>\n{\n   Id:%d,\n   targetName:%@,\n   phaseTableName:%@,\n   beginDate:%@\n}",[self class],self,self.ID,self.targetName,self.phaseTableName,self.beginDate];
}
@end
