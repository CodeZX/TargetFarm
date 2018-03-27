//
//  HomeFoundTargetSelectBar.h
//  TargetFarm
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "BasicView.h"

@interface HomeFoundTargetSelectBar : BasicView
@property (nonatomic,weak) NSString *content;
- (instancetype)initWithTitle:(NSString *)title ImagName:(NSString *)imagName Action:(VoidCompletionBlock)action;


@end
