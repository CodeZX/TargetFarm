//
//  HomePhaseBar.h
//  TargetFarm
//
//  Created by ZX on 2018/3/29.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TargetPhaseModel.h"
#import "TargetModel.h"
@interface HomePhaseBar : BasicView
@property (nonatomic,strong) TargetPhaseModel *targetPhaseModel;
@property (nonatomic,strong) NSString *phaseName;
@end
