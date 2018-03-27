//
//  BasicView.m
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "BasicView.h"

@implementation BasicView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        
       
        
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self= [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RandomColor;
    }
    
    return self;
}


@end
