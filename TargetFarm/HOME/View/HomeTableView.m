//
//  HomeTableView.m
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeTableView.h"

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return  self;
}

- (void)setup {
    
    self.estimatedRowHeight = 300;
    self.rowHeight = UITableViewAutomaticDimension;
    
    
}
@end
