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
    
    UILabel *contentLB = [UILabel new];
    contentLB.text  = @"马上完成了 3月31";
    contentLB.font = [UIFont systemFontOfSize:FONT_SIZE_LITTLE];
    contentLB.textColor = RandomColor;
    [self addSubview:contentLB];
    self.contentLB = contentLB;
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
}
@end
