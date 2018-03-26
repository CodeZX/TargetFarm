//
//  UIWindow+PresentViewController.m
//  TargetFarm
//
//  Created by ZX on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "UIWindow+PresentViewController.h"

@implementation UIWindow (PresentViewController)

//- (UIViewController *)visibleViewController {
//    UIViewController *rootViewController = self.rootViewController;
//    return [UIWindow getVisibleViewControllerFrom:rootViewController];
//}
//
//+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
//    if ([vc isKindOfClass:[UINavigationController class]]) {
//        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
//    } else if ([vc isKindOfClass:[UITabBarController class]]) {
//        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
//    } else {
//        if (vc.presentedViewController) {
//            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
//        } else {
//            return vc;
//        }
//    }
//}
@end
