//
//  TargetModel.h
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TargetModel : NSObject
@property (nonatomic,copy) NSString *targetStr;
@property (nonatomic,assign) NSInteger section;
@property (nonatomic,assign) BOOL unfold;
@property (nonatomic,strong) NSMutableArray *scheduleAry;
@end
