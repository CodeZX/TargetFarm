//
//  HomeCell.h
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonTableViewCell.h"

@interface HomeCell : CommonTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellBGImageView;
/** 任务 */
@property (weak, nonatomic) IBOutlet UILabel *titLab;
@property (weak, nonatomic) IBOutlet UITableView *subTabView;
@property (weak, nonatomic) IBOutlet UIButton *openCloseBtn;



@end
