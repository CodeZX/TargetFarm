//
//  UIViewController+HUD.h
//  TargetFarm
//
//  Created by ZX on 2018/3/27.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)
-(void)showSuccess:(NSString *)success;
-(void)showError:(NSString *)error;
-(void)showMessage:(NSString *)message;
-(void)showWaiting;
-(void)showLoading;
-(void)showLoadingWithMessage:(NSString *)message;
-(void)showSaving;
-(void)hideHUD;
@end
