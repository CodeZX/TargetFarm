//
//  FarmScene.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "FarmScene.h"


@interface FarmScene ()

//@property (strong, nonatomic) NSArray *<#UILabel#>;

@property (weak, nonatomic) SKSpriteNode *apple;
@property (nonatomic,strong) NSMutableArray *apples;
@property (nonatomic,strong) AVAudioPlayer *bgmPlayer;
@property (nonatomic,strong) NSArray *targetAry;
@property (nonatomic,strong) TargetModel *targetModel;
@end

@implementation FarmScene


- (id)initWithTargetAry:(NSArray *)targetAry NonceTargetModel:(TargetModel *)targetModel {
    
    self = [FarmScene nodeWithFileNamed:@"FarmScene.sks"];
    if (self) {
        self.targetModel = targetModel;
        self.targetAry = targetAry;
    }
    
    return self;
    
}
/** 做一些初始化的操作 */
- (void)didMoveToView:(SKView *)view {
    
    
    self.apples = [NSMutableArray new];
   
   
      [self seupNode];
    

    
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    [self.view addGestureRecognizer:swiperight];
    [self.view addGestureRecognizer:swipeleft];
    
    
    
    
}


- (void)seupNode {
    
    
    SKLabelNode *textNode = [SKLabelNode labelNodeWithText:self.targetModel.targetName];
    textNode.position = CGPointMake(0, SCREEN_HEIGHT/2 + 30);
    [self addChild:textNode];
     SKAction  *sizeAction1 = [SKAction scaleTo:2 duration:1];
     SKAction  *sizeAction2 = [SKAction scaleTo:1 duration:1];
    SKAction *groupAction = [SKAction sequence:@[
                                               sizeAction2,
                                               sizeAction1
                                                 
                                                 ]];
    
    
    SKAction * repeatAction  = [SKAction  repeatActionForever:groupAction];
    
    [textNode runAction:repeatAction];
    for (int index = 0; index < self.targetModel.phaseAry.count; index++) {
        
        NSString *appleName = [NSString stringWithFormat:@"//apple%d",index + 1];
        SKSpriteNode *apple = (SKSpriteNode *)[self childNodeWithName:appleName];
        apple.alpha = 1;
        
        SKAction *wind = [SKAction runBlock:^{
            // 进行推力
            NSLog(@"%@ ", @"进行风的推力");
            CGVector vector = CGVectorMake(3 + index/2.0, 0);
            [apple.physicsBody applyForce:vector atPoint:CGPointZero];
        }];
        SKAction *wait = [SKAction waitForDuration:20];
        SKAction *forever = [SKAction repeatActionForever:[SKAction sequence:@[wait, wind]]];
        [apple runAction:forever];
        [self.apples addObject:apple];
        
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
    UITouch *touch = [touches anyObject];
    
    CGPoint  position = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:position];
    
    int index = [[node.name substringFromIndex:node.name.length - 1] intValue];

    DEBUG_LOG(@"%d",index);
    
//    if ([node.name isEqualToString:@"apple1"]) {
//
//
//        int index = [[node.name substringFromIndex:node.name.length - 1] intValue];
//        NSNotification *notification;
//        switch (0) {
//            case 1:
//            {
//
//                TargetModel *model = self.targetAry[0];
//                notification = [[NSNotification alloc]initWithName:@"phaseModel" object:nil userInfo:@{@"phaseModel":model}];
//
//                break;
//            }
//
//
//            case 2:
//            {
//
//                TargetModel *model = self.targetAry[1];
//                notification = [[NSNotification alloc]initWithName:@"phaseModel" object:nil userInfo:@{@"phaseModel":model}];
//
//                break;
//            }
//            case 3:
//            {
//
//                TargetModel *model = self.targetAry[2];
//                notification = [[NSNotification alloc]initWithName:@"phaseModel" object:nil userInfo:@{@"phaseModel":model}];
//
//                break;
//            }
//
//            case 4:
//            {
//
//                TargetModel *model = self.targetAry[3];
//                notification = [[NSNotification alloc]initWithName:@"phaseModel" object:nil userInfo:@{@"phaseModel":model}];
//
//                break;
//            }
//
//            case 5:
//
//            {
//
//                TargetModel *model = self.targetAry[4];
//                notification = [[NSNotification alloc]initWithName:@"phaseModel" object:nil userInfo:@{@"phaseModel":model}];
//
//                break;
//            }
//            default:
//                break;
//        }
//
//
//       [[NSNotificationCenter defaultCenter] postNotification:notification];
//
//    }
    
    
}

- (void)swipe:(UISwipeGestureRecognizer *)reg {
    if (reg.direction == UISwipeGestureRecognizerDirectionRight || reg.direction == UISwipeGestureRecognizerDirectionLeft) {
        BOOL left = reg.direction == UISwipeGestureRecognizerDirectionLeft;
        
        NSLog(@"%@ ", left ? @"向左轻扫" : @"向右轻扫");
        
        FarmScene *scene;

        if (left) {
            
           
            NSInteger index =   [self.targetAry indexOfObject:self.targetModel];
            
            if (index + 1 == self.targetAry.count ) {
                
                return ;
            }

            scene = [[FarmScene alloc]initWithTargetAry:self.targetAry NonceTargetModel:self.targetAry[index + 1]];
        }else {
            
            NSInteger index = [self.targetAry indexOfObject:self.targetModel];
            if (index == 0) {
                
                return ;
            }

            scene = [[FarmScene alloc]initWithTargetAry:self.targetAry NonceTargetModel:self.targetAry[index - 1]];
            
        }
        
        
        scene.scaleMode = SKSceneScaleModeFill;
        SKTransition *transition = [SKTransition pushWithDirection:left ? SKTransitionDirectionLeft : SKTransitionDirectionRight duration:.5];
        [self.view presentScene:scene transition:transition];
    }
}


@end
