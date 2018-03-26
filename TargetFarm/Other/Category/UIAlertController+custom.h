//
//  UIAlertController+custom.h
//  TargetFarm
//
//  Created by ZX on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (custom)
+ (void)alertViewForShowOnViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message cancelBtnTitle:(NSString *)cancelBtnTitle cancelBtnBack:(void (^)())cancelBtnBack DefaultBtnTitle:(NSString *)DefaultBtnTitle DefaultBtnBack:(void (^)())DefaultBtnBack;
@end
