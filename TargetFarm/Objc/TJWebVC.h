//
//  TJWebVC.h
//  HKGoodColor
//
//  Created by chenkaijie on 2018/1/3.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJWebVC : UIViewController

@property(nonatomic,copy)NSString *urlStr;
- (instancetype)initWithUrlString:(NSString *)urlString;

@end
