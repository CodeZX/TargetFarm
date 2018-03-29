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

@property (nonatomic,strong) NSMutableArray *lableAry;
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
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLableClick)];
    // 2. 将点击事件添加到label上
     [contentLable addGestureRecognizer:labelTapGestureRecognizer];
     contentLable.userInteractionEnabled = YES; // 可以理解为设置label可被点击
}




// 3. 在此方法中设置点击label后要触发的操作
- (void)contentLableClick {
    
    self.targetModel.unfold = !self.targetModel.unfold;
   [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
    if (self.lableAry.count == 0) { return ;}
        
    for (UILabel *label in self.lableAry) {
            
            [label removeFromSuperview];
            
        }
    
    
}

- (void)setTargetModel:(TargetModel *)targetModel {
    
    _targetModel = targetModel;
    self.contentLable.text = targetModel.targetName;
    self.lableAry = [NSMutableArray new];
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
           
            [self.lableAry addObject:label];
        }
        
        
        
        [self.backgroundImg mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(400);
        }];
        
//        [UIView animateWithDuration:1 animations:^{
//            [self layoutIfNeeded];//这里是关键
//            //            self.backView.alpha = 0.35;//透明度的变化依然和老方法一样
//        } completion:^(BOOL finished) {
//            //动画完成后的代码
//
//
//        }];
        
       
        [self.contentLable mas_updateConstraints:^(MASConstraintMaker *make) {
            
            
            make.centerY.equalTo(self.centerY).offset(-100);
        }];
        
//        [UIView animateWithDuration:0.5f animations:^{
//            [self layoutIfNeeded];//这里是关键
//            //            self.backView.alpha = 0.35;//透明度的变化依然和老方法一样
//        } completion:^(BOOL finished) {
//            //动画完成后的代码
//        }];
        
        
    
    }else {
        
        [self.backgroundImg mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(140);
            
        }];
        
        [self.contentLable mas_updateConstraints:^(MASConstraintMaker *make) {
            
            
            make.centerY.equalTo(self.centerY);
        }];
        
       
       
        
       
        
    }
}
@end
