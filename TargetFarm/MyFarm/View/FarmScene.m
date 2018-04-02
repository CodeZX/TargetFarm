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
@end

@implementation FarmScene


- (instancetype)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        NSString *bgmPath = [[NSBundle mainBundle] pathForResource:@"MainBGM" ofType:@"mp3"];
        self.bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:bgmPath] error:NULL];
        self.bgmPlayer.numberOfLoops = -1;
        [self.bgmPlayer play];
    }
    
    return self;
}
/** 做一些初始化的操作 */
- (void)didMoveToView:(SKView *)view {
    
    
    self.apples = [NSMutableArray new];
    TargetManage *TM = [TargetManage sharedTargetManage];
    NSArray *targetAry = [TM allTarget];
    for (int index = 0; index < targetAry.count%5; index++) {
        
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
    
  

//    for (int index = 1; index < 4; index++) {
//
//        NSString *appleName = [NSString stringWithFormat:@"//apple%d",index];
//         SKSpriteNode *apple = (SKSpriteNode *)[self childNodeWithName:appleName];
//
//        SKAction *wind = [SKAction runBlock:^{
//            // 进行推力
//            NSLog(@"%@ ", @"进行风的推力");
//            CGVector vector = CGVectorMake(3 + index/2.0, 0);
//            [apple.physicsBody applyForce:vector atPoint:CGPointZero];
//        }];
//        SKAction *wait = [SKAction waitForDuration:20];
//        SKAction *forever = [SKAction repeatActionForever:[SKAction sequence:@[wait, wind]]];
//        [apple runAction:forever];
//         [self.apples addObject:apple];
//
//    }

//    SKSpriteNode *redApple = [[SKSpriteNode alloc]initWithImageNamed:@"hongpingguo"];
//    redApple.position = CGPointMake(100, 100);
//    [self addChild:redApple];
    
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swiperight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    [self.view addGestureRecognizer:swiperight];
    [self.view addGestureRecognizer:swipeleft];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint positionInScene = [touch locationInNode:self];
//    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:positionInScene];
//    if ([[touchedNode name] isEqualToString:@"apple1"])    {
//        NSLog(@"%@ ", @"这里可以进行点击事件操作");
//    }
    
    
    UITouch *touch = [touches anyObject];
    
    CGPoint  position = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:position];
    
    if ([node.name isEqualToString:@"apple1"]) {
        
       [[NSNotificationCenter defaultCenter] postNotificationName:@"push" object:nil];
        
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
