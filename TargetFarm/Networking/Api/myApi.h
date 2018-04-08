//
//  myApi.h
//  TargetFarm
//
//  Created by ZX on 2018/4/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface myApi : YTKRequest
- (instancetype)initWithCity:(NSString *)city;
@end
