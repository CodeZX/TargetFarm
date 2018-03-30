//
//  HomeTableCellContainerView.m
//  TargetFarm
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeTableCellContainerView.h"
#import "HomePhaseBar.h"
#import "HomeTableViewCell.h"


static int backgroundImgEdge = 5;
static int tagImgEdge = 33;
static int contentLableFont = 24;
static int phaseBarHeight = 60;
static int phaseBarEdge = 44;
static int backgroundImgHeight = 150;


@interface HomeTableCellContainerView ()


@property (nonatomic,weak) UIImageView *tagImg;
@property (nonatomic,weak) UILabel *contentLable;
@property (nonatomic,weak) UIImageView *backgroundImg;
//@property (nonatomic,weak) UILabel *targetName;
@property (nonatomic,weak) HomePhaseBar *lastPhaseBar;

@property (nonatomic,strong) NSMutableArray *phaseBarAry;
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
    self.phaseBarAry = [NSMutableArray new];
    UIImageView *backgroundImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing22"]];
    [self addSubview:backgroundImg];
    self.backgroundImg = backgroundImg;
    [self.backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(backgroundImgEdge,backgroundImgEdge,backgroundImgEdge,backgroundImgEdge));

    }];
    
    UIImageView *tagImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing1"]];
    [self addSubview:tagImg];
    self.tagImg = tagImg;
    [self.tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(tagImgEdge, tagImgEdge, tagImgEdge, tagImgEdge));
//        make.top.left.equalTo(30);
    }];
    
    UILabel *contentLable = [UILabel new];
    contentLable.textColor = UIColorFromRGB(0x2d2d2d);
    contentLable.font = [UIFont systemFontOfSize:contentLableFont*3/4];
    [self addSubview:contentLable];
    self.contentLable = contentLable;
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
    }];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLableClick)];
    // 2. 将点击事件添加到label上
     [contentLable addGestureRecognizer:labelTapGestureRecognizer];
     contentLable.userInteractionEnabled = YES;
}




// 3. 在此方法中设置点击label后要触发的操作
- (void)contentLableClick {
    
    self.targetModel.unfold = !self.targetModel.unfold;
    HomeTableViewCell *cell = (HomeTableViewCell *)[[self superview] superview];
    NSNotification *notification = [[NSNotification alloc]initWithName:@"update" object:nil userInfo:@{@"cell":cell}];
   [[NSNotificationCenter defaultCenter] postNotification:notification];
    if (self.phaseBarAry.count == 0) { return ;}
        
    [self deletePhaseBar];
    
    
}

- (void)deletePhaseBar {
    
    for (UILabel *label in self.phaseBarAry) {
        
        [label removeFromSuperview];
        
    }
    
}

- (void)setTargetModel:(TargetModel *)targetModel {
    
    _targetModel = targetModel;
    self.contentLable.text = targetModel.targetName;
     [self deletePhaseBar];
    
    
    if (_targetModel.unfold) {
        
       
        //_targetModel.scheduleAry.count
        for (int index = 0; index < 3 ; index++) {

            HomePhaseBar *phaseBar = [HomePhaseBar new];
            phaseBar.alpha = 0;
            [self addSubview:phaseBar];
            
            if (!self.lastPhaseBar) {
                
                [phaseBar mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLable.bottom).offset(45);
                    make.left.equalTo(self).offset(phaseBarEdge);
                    make.right.equalTo(self).offset(-phaseBarEdge);
                    make.height.equalTo(phaseBarHeight);
                }];
            
            }else {
                
                [phaseBar mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.lastPhaseBar.bottom);
                    make.left.right.equalTo(self.lastPhaseBar);
                    make.height.equalTo(phaseBarHeight);
                }];
                
            }
            self.lastPhaseBar = phaseBar;
           
            [self.phaseBarAry addObject:phaseBar];
        }
        
        
        self.backgroundImg.image = [UIImage jk_resizableHalfImage:@"beijing22"];
        [self.backgroundImg mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(phaseBarHeight * 4 + backgroundImgHeight);
        }];
        
        [self.contentLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).offset(-100);
        }];
        [self layoutIfNeeded];
        [UIView animateWithDuration:1 animations:^{
            
            for (HomePhaseBar *phaseBar in self.phaseBarAry) {
                
                phaseBar.alpha = 1;
            }
           
        } completion:nil];
        
        
        
    
    }else {
        
        self.backgroundImg.image = [UIImage imageNamed:@"beijing22"];
        [self.backgroundImg mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(backgroundImgHeight);
            
        }];
        
        [self.contentLable mas_updateConstraints:^(MASConstraintMaker *make) {
            
            
            make.centerY.equalTo(self.centerY);
        }];
        
        [self layoutIfNeeded];
       
        }
}
@end
