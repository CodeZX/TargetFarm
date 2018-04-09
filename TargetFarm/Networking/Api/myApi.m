//
//  myApi.m
//  TargetFarm
//
//  Created by ZX on 2018/4/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "myApi.h"

@implementation myApi
{
    
    NSString *_city;
}
- (instancetype)initWithCity:(NSString *)city {
    
    self = [super init];
    if (self) {
        _city = city;
        
    }
    
    return self;
}


- (NSString *)requestUrl {
    
//    return @"/open/api/weather/json.shtml";
    
    return @"/wordpad/aaa/bbb.action";
//    wordpad/aaa/bbb.action
}

- (YTKRequestMethod)requestMethod {
    
    return  YTKRequestMethodGET;
}

//- (id)requestArgument {
//
//    return @{@"city":_city};
//}
@end
