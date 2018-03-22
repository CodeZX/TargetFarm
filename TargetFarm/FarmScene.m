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

@end

@implementation FarmScene

/** 做一些初始化的操作 */
- (void)didMoveToView:(SKView *)view {
    _apple = (SKSpriteNode *)[self childNodeWithName:@"//apple1"];
    SKAction *wind = [SKAction runBlock:^{
        // 进行推力
        NSLog(@"%@ ", @"进行风的推力");
        CGVector vector = CGVectorMake(3, 0);
        [_apple.physicsBody applyForce:vector atPoint:CGPointZero];
    }];
    SKAction *wait = [SKAction waitForDuration:20];
    SKAction *forever = [SKAction repeatActionForever:[SKAction sequence:@[wait, wind]]];
    [_apple runAction:forever];
    
    
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    [self.view addGestureRecognizer:swiperight];
    [self.view addGestureRecognizer:swipeleft];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
    if ([[touchedNode name] isEqualToString:@"apple1"])    {
        NSLog(@"%@ ", @"这里可以进行点击事件操作");
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)reg {
    if (reg.direction == UISwipeGestureRecognizerDirectionRight || reg.direction == UISwipeGestureRecognizerDirectionLeft) {
        BOOL left = reg.direction == UISwipeGestureRecognizerDirectionLeft;
        
        NSLog(@"%@ ", left ? @"向左轻扫" : @"向右轻扫");
        
        FarmScene *scene = [FarmScene nodeWithFileNamed:@"FarmScene.sks"];
        scene.scaleMode = SKSceneScaleModeAspectFit;  
        
        SKTransition *transition = [SKTransition pushWithDirection:left ? SKTransitionDirectionLeft : SKTransitionDirectionRight duration:.5];
        [self.view presentScene:scene transition:transition];
    }
}


@end
