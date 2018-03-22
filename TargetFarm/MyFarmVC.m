//
//  MyFarmVC.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "MyFarmVC.h"
#import "FarmScene.h"

@interface MyFarmVC ()

@end

@implementation MyFarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    SKView *skView = [[SKView alloc] initWithFrame:self.view.bounds];
    
    //    MyScene *scene = [MyScene sceneWithSize:skView.bounds.size];
    FarmScene *scene = [FarmScene nodeWithFileNamed:@"FarmScene.sks"];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    self.view = skView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
