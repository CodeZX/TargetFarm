//
//  HomeTableSectionHeadView.h
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TargetModel.h"



@protocol HomeTableSectionHeadViewDelegate <NSObject>
- (void)unfoldForSection:(NSInteger)section;
@end
@interface HomeTableSectionHeadView : UIView
@property (nonatomic,copy) NSString *contentStr;
@property (nonatomic,weak) TargetModel *targetModel;
@property (nonatomic,weak) id <HomeTableSectionHeadViewDelegate> delegate;
@end





