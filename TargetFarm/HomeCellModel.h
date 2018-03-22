//
//  HomeCellModel.h
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonTableViewCellModel.h"
#import "HomeSubCellModel.h"


@interface HomeCellModel : CommonTableViewCellModel

@property (strong, nonatomic) NSArray <CommonSectionModel *>*subTabViewSectionArray;

@property (assign, nonatomic) BOOL openSubTabView;

@end
