//
//  HomeAddPhaseCell.h
//  TargetFarm
//
//  Created by apple on 2018/3/23.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "BasicTableViewCell.h"
#import "TargetPhaseModel.h"

@interface HomeAddPhaseCell : BasicTableViewCell
@property (nonatomic,strong) TargetPhaseModel *targetPhaseModel;
@property (nonatomic, strong) NSString *title;
@end
