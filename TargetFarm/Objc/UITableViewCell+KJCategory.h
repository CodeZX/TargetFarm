//
//  UITableViewCell+KJCategory.h
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/8.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (KJCategory)

- (UITableView *)currentTableView;

- (UIViewController *)currentViewController;
@end
