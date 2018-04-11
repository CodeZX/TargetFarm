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
@property (nonatomic,weak) UILabel *endDateLB;
@property (nonatomic,weak) UILabel *phaseLB;
@property (nonatomic,weak) UIButton *stateBtn;
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
        make.top.equalTo(self).offset(5);
    }];
    
    
    UILabel *phaseLB = [UILabel new];
//    phaseLB.text  = @"马上完成了 3月31";
    phaseLB.font = FONT_PT_FROM_PX(20);
    phaseLB.textColor = UIColorFromRGB(0x212225);
    [self addSubview:phaseLB];
    self.phaseLB = phaseLB;
    [self.phaseLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
        
    }];
    
    UILabel *contentLB = [UILabel new];
    contentLB.text  = @"马上完成了 3月31";
    contentLB.font = FONT_PT_FROM_PX(20);
    contentLB.textColor = UIColorFromRGB(0x212225);
    [self addSubview:contentLB];
    self.contentLB = contentLB;
    [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
       
        make.bottom.equalTo(self.centerY).offset(-2);
    }];
    
    
    UILabel *endDateLB = [UILabel new];
//    endDateLB.text  = @"马上完成了 3月31";
    endDateLB.font = FONT_PT_FROM_PX(20);
    endDateLB.textColor = UIColorFromRGB(0x212225);
    [self addSubview:endDateLB];
    self.endDateLB = endDateLB;
    [self.endDateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.centerY).offset(2);
    }];
    
    
    UIButton *stateBtn = [[UIButton alloc]init];
//    [stateBtn setTitle:@"未完成" forState:UIControlStateNormal];
//    [stateBtn setTitle:@"已完成" forState:UIControlStateSelected];
    [stateBtn setImage:[UIImage imageNamed:@"buttonNormal"] forState:UIControlStateNormal];
    [stateBtn setImage:[UIImage imageNamed:@"buttonSelected"] forState:UIControlStateSelected];
    stateBtn.titleLabel.font = FONT_PT_FROM_PX(20);
    [stateBtn setTitleColor:BlackColor forState:UIControlStateNormal];

    [stateBtn addTarget:self action:@selector(stateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:stateBtn];
    self.stateBtn = stateBtn;
    [stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
    }];
}


- (void)stateBtnClick:(UIButton *)btn {
    
    btn.selected  = !btn.selected;
    
    self.targetPhaseModel.accomplish = btn.selected ? accomplishStateEnd:accomplishStateMarch;
    TargetManage *TM = [TargetManage sharedTargetManage];
    if ([TM upDatePhaseWithPhaseName:self.phaseName PrimaryKey:self.targetPhaseModel.id Option:@{@"accomplish":@(self.targetPhaseModel.accomplish)}]) {  DEBUG_LOG(@"更改成功");}
    
}
- (void)setTargetPhaseModel:(TargetPhaseModel *)targetPhaseModel {
    
    _targetPhaseModel = targetPhaseModel;
    self.contentLB.text  = targetPhaseModel.content;
    long  int day = [targetPhaseModel.endDate jk_day];
    long  int month = [targetPhaseModel.endDate jk_month];
    NSString *endDateStr = [NSString stringWithFormat:@"%ld月%ld日前",month,day];
    self.endDateLB.text = endDateStr;
    self.phaseLB.text = [NSString stringWithFormat:@"阶段%d",1];
    self.stateBtn.selected = targetPhaseModel.accomplish?YES:NO;
}
@end
