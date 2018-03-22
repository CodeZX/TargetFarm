//
//  KJCellModel.h
//  RAC空项目
//
//  Created by chenkaijie on 2018/2/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonTableViewCellModel.h"

@interface KJCellModel : CommonTableViewCellModel

@property (copy, nonatomic) NSString *left_ImageString2;
@property (copy, nonatomic) NSString *left_Title3;
@property (copy, nonatomic) NSString *left_subTitle4;
@property (copy, nonatomic) NSString *right_alikePrice7;
@property (copy, nonatomic) NSString *right_imageViewString8;
@property (copy, nonatomic) NSString *right_arrowImageString9;


@property (assign, nonatomic) BOOL hiddenSwitch;
@property (assign, nonatomic) BOOL switchOn;


@property (copy, nonatomic) void (^swicthBlock)(BOOL switchOn);


@end
