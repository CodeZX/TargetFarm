//
//  TargetPhaseModel.m
//  TargetFarm
//
//  Created by apple on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "TargetPhaseModel.h"

@implementation TargetPhaseModel


- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"publisher"]) {
        if (oldValue == nil) return @"";
    } else if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [fmt dateFromString:oldValue];
    }
    
    return oldValue;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"content":@"title",
             @"beginDate":@"begin",
             @"endDate":@"end"
             };
}


@end
