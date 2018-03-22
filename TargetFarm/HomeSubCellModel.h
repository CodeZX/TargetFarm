//
//  HomeSubCellModel.h
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/8.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonTableViewCellModel.h"

@interface HomeSubCellModel : CommonTableViewCellModel



/**
 * 标题 (黄山5日游)
 */
@property (copy, nonatomic) NSString *title;
/**
 * 5月1日前
 */
@property (copy, nonatomic) NSString *subTitle;

/**
 * 就是右边的图片
 */
@property (assign, nonatomic) BOOL complete;

@end
