//
//  HomeSubCell.h
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/8.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "CommonTableViewCell.h"

@interface HomeSubCell : CommonTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *levelLab;

@property (weak, nonatomic) IBOutlet UILabel *topLab;
@property (weak, nonatomic) IBOutlet UILabel *bottomLab;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
