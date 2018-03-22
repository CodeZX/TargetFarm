//
//  HomeTableViewCell.h
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "BasicTableViewCell.h"
#import "TargetScheduleModel.h"
#import "TargetModel.h"

@interface HomeTableViewCell : BasicTableViewCell
@property (nonatomic,strong) TargetScheduleModel *targetScheduleModel;
@property (nonatomic,strong) TargetModel *targetModel;
//+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)Identifier;
@end
