//
//  TargetModel.h
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TargetModel : NSObject
@property (nonatomic,assign) int ID;
@property (nonatomic,copy) NSString *targetName;
@property (nonatomic,copy) NSDate *beginDate;
@property (nonatomic,copy) NSDate *endDate;
@property (nonatomic,assign,getter=isawoke) BOOL awoke;
@property (nonatomic,copy) NSDate *awokeDate;
@property (nonatomic,copy) NSString *phaseTableName;
@property (nonatomic,strong) NSMutableArray *scheduleAry;


@property (nonatomic,copy) NSString *targetStr;
@property (nonatomic,assign) NSInteger section;
@property (nonatomic,assign) BOOL unfold;

@end
