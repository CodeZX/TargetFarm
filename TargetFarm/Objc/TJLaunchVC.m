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
#import "TJWebVC.h"
#import <WebKit/WebKit.h>

@interface TJLaunchVC ()

@end

@implementation TJLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSURL *url = [NSURL URLWithString:@"http://219.235.6.7:8080/wordpad/img/tfboy.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data) {
        NSURL *url = [NSURL URLWithString:@"http://219.235.6.7:8080/wordpad/aaa/ccc.action"];
        NSString *urlStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        DEBUG_LOG(@"%@",urlStr);
//        TJWebVC *webVC = [[TJWebVC alloc]initWithUrlString:@"https://www.baidu.com"];
        WKWebView *web = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [web loadRequest:rq];
        
       
        
        [self.view addSubview:web];
//        [self.view addSubview:webVC.view];
        
        
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:data]];
        [self.view addSubview:imgView];
        imgView.frame  = [UIScreen mainScreen].bounds;
        
        
        [UIView animateWithDuration:3 animations:^{
            
            
            imgView.alpha = 0.1;
            
        } completion:^(BOOL finished) {
            
            [imgView removeFromSuperview];
            
        }];
        
    } else {
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow *window = delegate.window;
        [self change_RootVC:[FarmTabBarVC new] window:window];
        
    }
   
    
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
