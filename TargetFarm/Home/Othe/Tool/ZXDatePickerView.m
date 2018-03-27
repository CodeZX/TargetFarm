//
//  ZXDatePickerView.m
//  TargetFarm
//
//  Created by apple on 2018/3/27.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "ZXDatePickerView.h"


@interface ZXDatePickerView ()
@property (nonatomic,weak) UIDatePicker *datePicker;
@property (nonatomic,copy) NSDateCompletionBlock action;
@end
@implementation ZXDatePickerView

- (instancetype)initWithAction:(NSDateCompletionBlock)action {
    
    self = [super init];
    if (self) {
        
        self.action = action;
    }
    
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    
    return self;
}
- (void)setupUI  {
    
//    self.backgroundColor = [UIColor colorWithRed:122/255.0 green:123/255.0 blue:234/255.0 alpha:1];
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.6);
//    self.alpha = .9;[UIColor colorWithWhite:0.f alpha:0.7];[UIColor colorWithRed:122/255.0 green:123/255.0 blue:234/255.0 alpha:0.7];  RGBACOLOR(1, 1, 1, 0.9);
    
    
    UIDatePicker  *datePicker = [UIDatePicker new];
    datePicker.backgroundColor = WhiteColor;
    datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_ch"];
    // 设置时区，中国在东八区
//    datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [datePicker addTarget:self action:@selector(seletedBirthyDate:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:datePicker];
    self.datePicker = datePicker;
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.height.equalTo(216);
        make.centerY.equalTo(self);
    }];
    
    
    NSString *srogn = [NSString new];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.datePicker.date) {
        
        self.action([NSDate date]);
    }
    self.frame = CGRectMake(0, 0, 0, 0);
    
    
    
}
- (void)seletedBirthyDate:(UIDatePicker *)datePicker {
    
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    DEBUG_LOG(@"%@",[dateFormatter stringFromDate:datePicker.date]);
   
    self.action(datePicker.date);
}
@end
