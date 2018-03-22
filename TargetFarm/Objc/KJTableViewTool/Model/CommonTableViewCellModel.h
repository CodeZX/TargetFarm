//
//  CommonTableViewCellModel.h
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonSectionModel.h"

@interface CommonTableViewCellModel : NSObject

/**
 *  务必指定是否以注册的形式返回cell，还是以代码形式注册， 而且注册cell的重用标识符要和Cell类名一样，Swift忽略命名空间
 */
@property (assign, nonatomic) BOOL isRegisterXib;

@end
