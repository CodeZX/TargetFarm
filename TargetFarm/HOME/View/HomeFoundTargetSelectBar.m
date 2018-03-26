//
//  HomeFoundTargetSelectBar.m
//  TargetFarm
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeFoundTargetSelectBar.h"


@interface HomeFoundTargetSelectBar ()
@property (nonatomic,strong) NSString *title;
@property (nonatomic,copy) VoidCompletionBlock action;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UIButton *selectBtn;
@property (nonatomic,strong) NSString *BtnImageName;
@end
@implementation HomeFoundTargetSelectBar


- (instancetype)initWithTitle:(NSString *)title ImagName:(NSString *)imagName Action:(VoidCompletionBlock)action {
    
    self = [super init];
    if (self) {
        
        
        self.title = title;
        self.action = action;
        self.BtnImageName = imagName;
        [self setupUI];
    }
    return self;
    
}


- (void)setupUI {
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = self.title;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(self);
    }];
    
    UIButton *selectBtn  = [UIButton new];
//    selectBtn.backgroundColor = RandomColor;
    
    [selectBtn setTitleColor:RandomColor forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectBtn];
    self.selectBtn = selectBtn;
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(self);
        
    }];
    
    if (self.BtnImageName) {
        
        [selectBtn setImage:[UIImage imageNamed:self.BtnImageName] forState:UIControlStateNormal];
    
    }else {
        
        [selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
    }
    
    
}

- (void)selectBtnClick:(UIButton *)Btn {
    
    self.action();
    
}
@end