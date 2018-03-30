//
//  HomeAddPhaseViewController.h
//  TargetFarm
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeFoundTargetViewController.h"

@class HomeAddPhaseViewController;
@protocol  HomeAddPhaseDelegate <NSObject>

- (void)homeAddPhase:(HomeAddPhaseViewController *)homeAddPhase didAddInPhase:(NSString *)phase;
@end
@interface HomeAddPhaseViewController : BasicViewController
@property (nonatomic,weak) id <HomeAddPhaseDelegate>delegate;

@end
