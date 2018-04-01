//
//  HomePhaseBar.m
//  TargetFarm
//
//  Created by ZX on 2018/3/29.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomePhaseBar.h"


@interface HomePhaseBar ()

@property (nonatomic,weak) UILabel *contentLB;
@property (nonatomic,weak) UIView *line;
@end
@implementation HomePhaseBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    self.backgroundColor = ClearColor;
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xe7dfc5);
    [self addSubview:line];
    self.line = line;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(1);
    }];
    UILabel *contentLB = [UILabel new];
    contentLB.text  = @"马上完成了 3月31";
    contentLB.font = FONT_PT_FROM_PX(20);
    contentLB.textColor = UIColorFromRGB(0x212225);
    [self addSubview:contentLB];
    self.contentLB = contentLB;
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(5);
    }];
    
}

- (void)setTargetPhaseModel:(TargetPhaseModel *)targetPhaseModel {
    
    _targetPhaseModel = targetPhaseModel;
    self.contentLB.text  = targetPhaseModel.content;
}
@end
