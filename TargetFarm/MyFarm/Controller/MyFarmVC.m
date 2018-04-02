//
//  MyFarmVC.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "MyFarmVC.h"
#import "FarmScene.h"
#import "HomeMyTargetController.h"


@interface MyFarmVC ()

@end

@implementation MyFarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"push" object:nil];
    
}
- (void)push:(id)sender {
    
     HomeMyTargetController *VC = [HomeMyTargetController new];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    SKView *skView = [[SKView alloc] initWithFrame:self.view.bounds];
    
    //    MyScene *scene = [MyScene sceneWithSize:skView.bounds.size];
    FarmScene *scene = [FarmScene nodeWithFileNamed:@"FarmScene.sks"];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    self.view = skView;
    
    TargetManage *targetManage= [TargetManage sharedTargetManage];
    
    NSArray *ary = [targetManage allTarget];
    
    DEBUG_LOG(@"%d",ary.count);
    
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
