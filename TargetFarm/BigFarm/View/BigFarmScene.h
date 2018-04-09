//
//  BigFarmScene.h
//  TargetFarm
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BigFarmScene : SKScene

- initWithTargetAry:(NSArray *)targetAry NonceTargetModel:(TargetModel *)targetModel;
-(TargetModel *)getTargetModel;
@end
