//
//  HomeSubCell.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/8.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeSubCell.h"
#import "HomeSubCellModel.h"

@implementation HomeSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupData:(CommonTableViewCellModel *)cellModel section:(NSInteger)section row:(NSInteger)row tableView:(UITableView *)tableView {
    HomeSubCellModel *model = (HomeSubCellModel *)cellModel;
    self.topLab.text = model.title;
    self.bottomLab.text = model.subTitle;
    
    // 这还要进行  levelLab文字设置 和  selectBtn 图片设置
}

@end
