//
//  HomeTableCellContainerView.h
//  TargetFarm
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "BasicView.h"
#import "TargetModel.h"

@interface HomeTableCellContainerView : BasicView
@property (nonatomic,strong) TargetModel *targetModel;
- (void)deletePhaseBar;
@end
