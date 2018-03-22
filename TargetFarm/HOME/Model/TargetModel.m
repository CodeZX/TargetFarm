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
        
        TargetScheduleModel *targetScheduleModel3 = [TargetScheduleModel new];
        targetScheduleModel3.contentStr = @"下午";
        [_scheduleAry addObject:targetScheduleModel3];
        
        TargetScheduleModel *targetScheduleModel4 = [TargetScheduleModel new];
        targetScheduleModel4.contentStr = @"下午";
        [_scheduleAry addObject:targetScheduleModel4];
        
        TargetScheduleModel *targetScheduleModel5 = [TargetScheduleModel new];
        targetScheduleModel5.contentStr = @"下午";
        [_scheduleAry addObject:targetScheduleModel5];
    }
    
    return _scheduleAry;
}
@end
