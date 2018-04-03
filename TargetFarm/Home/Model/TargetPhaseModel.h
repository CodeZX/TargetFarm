//
//  TargetPhaseModel.h
//  TargetFarm
//
//  Created by apple on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, accomplishState) {
    accomplishStateMarch = 0,
    accomplishStateEnd
};



@interface TargetPhaseModel : NSObject
@property (nonatomic,assign) int id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSDate *beginDate;
@property (nonatomic,copy) NSDate *endDate;
@property (nonatomic,copy) NSDate *awokeDate;
@property (nonatomic,assign) accomplishState accomplish;

@end
