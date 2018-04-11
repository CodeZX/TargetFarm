//
//  BigFarmScene.m
//  TargetFarm
//
//  Created by apple on 2018/4/9.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "BigFarmScene.h"

@interface BigFarmScene()


@property (weak, nonatomic) SKSpriteNode *apple;
@property (nonatomic,strong) NSMutableArray *apples;
@property (nonatomic,strong) AVAudioPlayer *bgmPlayer;
@property (nonatomic,strong) NSArray *targetAry;
@property (nonatomic,strong) TargetModel *targetModel;
@property (nonatomic,strong) SKSpriteNode *indicatorNode;

@end

@implementation BigFarmScene


- (id)initWithTargetAry:(NSArray *)targetAry NonceTargetModel:(TargetModel *)targetModel {
    
    self = [BigFarmScene nodeWithFileNamed:@"BigFarm.sks"];
    if (self) {
        self.targetModel = targetModel;
        self.targetAry = targetAry;
        //        self.anchorPoint = CGPointMake(0, 0);
    }
    
    return self;
    
}

- (TargetModel *)getTargetModel {
    
    return self.targetModel;
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
    textNode.position = CGPointMake(0, SCREEN_HEIGHT/2 + 50);
    [self addChild:textNode];
    
    SKAction  *sizeAction1 = [SKAction scaleTo:2 duration:1];
    SKAction  *sizeAction2 = [SKAction scaleTo:1 duration:1];
    SKAction *alphaInAction  = [SKAction fadeInWithDuration:1];
    
    SKAction *alphaOutAction = [SKAction fadeOutWithDuration:1];
    
    
    SKAction *groupAction1 = [SKAction group:@[
                                               sizeAction1,
                                               alphaInAction
                                               ]];
    SKAction *groupAction2 = [SKAction group:@[
                                               sizeAction2,
                                               alphaOutAction
                                               ]];
    
    
    
    SKAction *groupAction = [SKAction sequence:@[
                                                 groupAction1,
                                                 groupAction2
                                                 
                                                 ]];
    
    
    SKAction * repeatAction  = [SKAction  repeatActionForever:groupAction];
    
    [textNode runAction:repeatAction];
    for (int index = 0; index < self.targetModel.phaseAry.count; index++) {
        
        if (index == 4) {
            
            break;
        }
        NSString *appleName = [NSString stringWithFormat:@"apple%d",index + 1];
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
    
    NSRange range =  [node.name rangeOfString:@"apple"];
    if (range.length != 0) {
        
        int index = [[node.name substringFromIndex:node.name.length - 1] intValue];
        
        DEBUG_LOG(@"%d",index);
        
        //         SKSpriteNode *indicatorNode = (SKSpriteNode *)[self childNodeWithName:indicator];
        //         SKAction *turnAction = [SKAction action]
        
        
        if (self.indicatorNode) {
            
            SKAction *moveX = [SKAction moveByX:self.frame.size.width y:0 duration:.8];
            SKAction *moveY = [SKAction moveByX:0 y:30 duration:.5];
            SKAction *scaleAction = [SKAction scaleBy:.4 duration:.5];
            SKAction *group = [SKAction group:@[moveX,scaleAction]];
            SKAction *removeAciton = [SKAction removeFromParent];
            SKAction *groupAction = [SKAction sequence:@[moveY,group,removeAciton]];
            
            
            //        [s addChild:textNode];
            
            
            [self.indicatorNode runAction:groupAction];
            
            self.indicatorNode = nil;
            
            
        }else {
            
            
            SKSpriteNode *indicatorNode = [SKSpriteNode spriteNodeWithImageNamed:@"4152"];//anniu2
            indicatorNode.position = CGPointMake(-SCREEN_WIDTH, -SCREEN_HEIGHT/2 + 50);
            indicatorNode.size = CGSizeMake(100, 100);
            [self addChild:indicatorNode];
            self.indicatorNode = indicatorNode;
            SKAction *moveX = [SKAction moveByX:SCREEN_WIDTH/2 y:0 duration:.5];
            SKAction *moveY = [SKAction moveByX:0 y:-10 duration:.3];
            SKAction *scaleAction = [SKAction scaleBy:2 duration:.3];
            SKAction *group = [SKAction group:@[moveY,scaleAction]];
            
            SKAction *groupAction = [SKAction sequence:@[moveX,group]];
            
            SKLabelNode *textNode = [SKLabelNode labelNodeWithText:self.targetModel.targetName];
            textNode.position = CGPointMake(0,20);
            TargetPhaseModel *model = self.targetModel.phaseAry[index - 1];
            textNode.text = model.content;
            textNode.fontColor = [SKColor blackColor];
            textNode.fontSize = 12;
            //        [s addChild:textNode];
            [indicatorNode addChild:textNode];
            
            [indicatorNode runAction:groupAction];
            
        }
        
        
        
    }
    
    
   

}

- (void)swipe:(UISwipeGestureRecognizer *)reg {
    
    if (!self.targetAry.count) {
        
        return ;
    }
    if (reg.direction == UISwipeGestureRecognizerDirectionRight || reg.direction == UISwipeGestureRecognizerDirectionLeft) {
        BOOL left = reg.direction == UISwipeGestureRecognizerDirectionLeft;
        
        NSLog(@"%@ ", left ? @"向左轻扫" : @"向右轻扫");
        
        BigFarmScene *scene;
        
        
        if (left) {
            
            
            NSInteger index =   [self.targetAry indexOfObject:self.targetModel];
            
            if (index + 1 == self.targetAry.count ) {
                
                return ;
            }
            
            scene = [[BigFarmScene alloc]initWithTargetAry:self.targetAry NonceTargetModel:self.targetAry[index + 1]];
        }else {
            
            NSInteger index = [self.targetAry indexOfObject:self.targetModel];
            if (index <= 0) {
                
                return ;
            }
            
            scene = [[BigFarmScene alloc]initWithTargetAry:self.targetAry NonceTargetModel:self.targetAry[index - 1]];
            
        }
        
        
        scene.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *transition = [SKTransition pushWithDirection:left ? SKTransitionDirectionLeft : SKTransitionDirectionRight duration:.5];
        [self.view presentScene:scene transition:transition];
    }
}


@end

