//
//  UIAlertController+custom.m
//  TargetFarm
//
//  Created by ZX on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "UIAlertController+custom.h"

@implementation UIAlertController (custom)
+ (void)alertViewForShowOnViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message cancelBtnTitle:(NSString *)cancelBtnTitle cancelBtnBack:(void (^)())cancelBtnBack DefaultBtnTitle:(NSString *)DefaultBtnTitle DefaultBtnBack:(void (^)())DefaultBtnBack {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        cancelBtnBack();
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:DefaultBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        DefaultBtnBack();
        
    }]];
    
    
    
    //    [alertController addAction:[UIAlertAction actionWithTitle:@"警告" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //
    //        NSLog(@"点击警告");
    //
    //    }]];
    
    
    
    //    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //
    //        NSLog(@"添加一个textField就会调用 这个block");
    //
    //    }];
    
    
    
    // 由于它是一个控制器 直接modal出来就好了
    
    if (viewController == nil) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        viewController = [window jk_currentViewController];
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
    
}
@end
