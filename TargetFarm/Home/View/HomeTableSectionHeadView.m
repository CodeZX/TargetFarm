//
//  HomeTableSectionHeadView.m
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeTableSectionHeadView.h"


@interface HomeTableSectionHeadView ()

@property (nonatomic,weak) UILabel *contentLabel;

@end
@implementation HomeTableSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = RandomColor;
    
    UILabel *contentLable = [UILabel new];
    contentLable.backgroundColor = RandomColor;
    contentLable.textColor = RandomColor;
    [self addSubview:contentLable];
    self.contentLabel = contentLable;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(44);
    }];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
//    //属性设置
//    tap.numberOfTapsRequired = 2;
//    //设置手指字数
//    tap.numberOfTouchesRequired = 1;
//    [self addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    //属性设置
    //最小长按时间
    longPress.minimumPressDuration = .3;
    [self addGestureRecognizer:longPress];
    
    
}
#pragma mark --- UITapGestureRecognizer 轻拍手势事件 ---

-(void)tapView:(UITapGestureRecognizer *)sender{
    NSLog(@"轻拍");
    //设置轻拍事件改变testView的颜色
    self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(unfoldForSection:)])
    {
        // 调用代理方法
        [self.delegate unfoldForSection:1];
    }
}



#pragma mark langPress 长按手势事件
-(void)longPress:(UILongPressGestureRecognizer *)sender{
    //进行判断,在什么时候触发事件
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按状态");
        //改变testView颜色
        self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        self.targetModel.unfold = !self.targetModel.unfold;
        if (self.delegate && [self.delegate respondsToSelector:@selector(unfoldForSection:)])
        {
            // 调用代理方法
            [self.delegate unfoldForSection:self.targetModel.section];
        }
        
        
    }
}


- (void)setContentStr:(NSString *)contentStr {
    
    _contentStr = contentStr;
    
//    self.contentLabel.text = _contentStr;
}

- (void)setTargetModel:(TargetModel *)targetModel {
    
    _targetModel = targetModel;
    
    self.contentLabel.text = _targetModel.targetStr;
}

@end
