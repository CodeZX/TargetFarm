//
//  HomeTableCellContainerView.m
//  TargetFarm
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeTableCellContainerView.h"


@interface HomeTableCellContainerView ()


@property (nonatomic,weak) UIImageView *tagImg;
@property (nonatomic,weak) UILabel *contentLable;
@property (nonatomic,weak) UIImageView *backgroundImg;
@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) UILabel *lastLabel;
@end
@implementation HomeTableCellContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI {
    
    self.backgroundColor  = MotifColor;
    
    UIImageView *backgroundImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing22"]];
    [self addSubview:backgroundImg];
    self.backgroundImg = backgroundImg;
    [self.backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(5, 5, 5, 5));

    }];
    
    UIImageView *tagImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing1"]];
    [self addSubview:tagImg];
    self.tagImg = tagImg;
    [self.tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(30, 30, 30, 30));
//        make.top.left.equalTo(30);
    }];
    
    UILabel *contentLable = [UILabel new];
    //    contentLable.backgroundColor = RandomColor;
    contentLable.textColor = RandomColor;
    [self addSubview:contentLable];
    self.contentLable = contentLable;
    //    self.contentLable.text    = @"1111";
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.top.equalTo(self.top).offset(50);
        
        make.center.equalTo(self);
    }];
    
}


- (void)setTargetModel:(TargetModel *)targetModel {
    
    _targetModel = targetModel;
    self.contentLable.text = targetModel.targetName;
    
    if (_targetModel.unfold) {
        
       
        
        for (int index = 0; index <  _targetModel.scheduleAry.count; index++) {

            UILabel *label = [UILabel new];
            label.text = @"阶段一：";
            [self addSubview:label];
            if (!self.lastLabel) {
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLable.bottom);
                    make.left.equalTo(self.contentLable);
                }];
            }else {
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.lastLabel.bottom);
                    make.left.equalTo(self.contentLable);
                }];
                
            }
            self.lastLabel = label;
           
            
        }
        
        
        
        [self.backgroundImg mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(400);
        }];
        [self.contentLable mas_updateConstraints:^(MASConstraintMaker *make) {

            
            make.centerY.equalTo(self.centerY).offset(-100);
        }];
        
        
        [UIView animateWithDuration:0.5f animations:^{
            [self layoutIfNeeded];//这里是关键
//            self.backView.alpha = 0.35;//透明度的变化依然和老方法一样
        } completion:^(BOOL finished) {
            //动画完成后的代码
        }];
    
    }else {
        
        
    }
}
@end
