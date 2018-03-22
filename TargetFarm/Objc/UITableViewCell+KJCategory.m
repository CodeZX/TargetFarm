//
//  UITableViewCell+KJCategory.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/8.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "UITableViewCell+KJCategory.h"

@implementation UITableViewCell (KJCategory)

- (UITableView *)currentTableView {
    UITableView *current = (UITableView *)self.nextResponder;
    return current;
}

- (UIViewController *)currentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
