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


- (NSMutableArray *)scheduleAry {
    
    if (!_scheduleAry) {
        
        _scheduleAry = [NSMutableArray new];
        TargetScheduleModel *targetScheduleModel1 = [TargetScheduleModel new];
        targetScheduleModel1.contentStr = @"上午";
        [_scheduleAry addObject:targetScheduleModel1];
        
        
        TargetScheduleModel *targetScheduleModel2 = [TargetScheduleModel new];
        targetScheduleModel2.contentStr = @"下午";
        [_scheduleAry addObject:targetScheduleModel2];
    }
    
    return _scheduleAry;
}
@end
