//
//  TJLaunchVC.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/28.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "TJLaunchVC.h"
#import "AppDelegate.h"
#import "FarmTabBarVC.h"

@interface TJLaunchVC ()

@end

@implementation TJLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    [self change_RootVC:[FarmTabBarVC new] window:window];
    
//    if ([LightStorageManager loadWeb]) {
//        NSString *urlString = [LightStorageManager objectForKey:WebUrlKEY];
//        // 加载web客户的
//        TJWebVC *webV = [[TJWebVC alloc] initWithUrlString:urlString];
//        [self change_RootVC:webV window:window];
//    } else {
//        [self change_RootVC:[BaseGameViewController new] window:window];
//    }
}


- (void)change_RootVC:(UIViewController *)rootVC window:(UIWindow *)window {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        void (^animation)()  = ^{
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            window.rootViewController = rootVC;
            [UIView setAnimationsEnabled:oldState];
        };
        
        [UIView transitionWithView:window
                          duration:0.5f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:animation
                        completion:nil];
    });
}


@end
