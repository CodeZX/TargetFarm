//
//  FarmTabBarVC.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "FarmTabBarVC.h"


#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"



@interface FarmTabBarVC ()

@end

@implementation FarmTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tabBar.backgroundImage = [UIImage jk_imageWithColor:MotifColor];
    self.tabBar.shadowImage = [UIImage jk_imageWithColor:WhiteColor];
    self.tabBar.backgroundColor = MotifColor;

    
  
    
    
    
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
//    [self.tabBar setBackgroundImage:[UIImage jk_imageWithColor:MotifColor]];
//    [self.tabBar setShadowImage:[UIImage jk_imageWithColor:MotifColor]];
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"HomeViewController",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"shouye",
                                   kSelImgKey : @"首页"},
                                 
                                 @{kClassKey  : @"MyFarmVC",
                                   kTitleKey  : @"我的农场",
                                   kImgKey    : @"wodenongchang",
                                   kSelImgKey : @"wodenongchangxuanzhong"},
                                 
                                 @{kClassKey  : @"BigFarmVC",
                                   kTitleKey  : @"大农场",
                                   kImgKey    : @"dasnongchang",
                                   kSelImgKey : @"danongchang"}
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        BasicNavigationController *nav = [[BasicNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
