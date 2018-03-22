//
//  CommonTableViewCell.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommonTableViewCellModel;

@interface CommonTableViewCell : UITableViewCell

@property (nonatomic, strong) CommonTableViewCellModel *cellModel;

- (void)setupData:(CommonTableViewCellModel *)cellModel section:(NSInteger)section row:(NSInteger)row tableView:(UITableView *)tableView;

@end
