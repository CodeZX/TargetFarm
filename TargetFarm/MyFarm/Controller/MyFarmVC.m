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
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) NSMutableArray *targetAry;
@end

@implementation MyFarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
//    TargetManage *targetManage= [TargetManage sharedTargetManage];
    
//    NSArray *ary = [targetManage allTarget];
    
    //    DEBUG_LOG(@"%d",ary.count);
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"phaseModel" object:nil];
    
}
- (void)push:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    TargetModel *model = userInfo[@"phaseModel"];
    
     HomeMyTargetController *VC = [HomeMyTargetController new];
    VC.targerModel = model;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [self.audioPlayer play];
    TargetManage *TM = [TargetManage sharedTargetManage];
    self.targetAry = [TM allTarget];
    for (TargetModel *targerModel in self.targetAry) {
        
        targerModel.phaseAry  = [TM allPhaseFromPhaseName:targerModel.phaseTableName];
        
    }
    SKView *skView = [[SKView alloc] initWithFrame:self.view.bounds];
    
    //    MyScene *scene = [MyScene sceneWithSize:skView.bounds.size];
    
    FarmScene *scene = [[FarmScene alloc]initWithTargetAry:self.targetAry NonceTargetModel:[self.targetAry firstObject ]];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    self.view = skView;
    
}

- (void)viewWillDisappear:(BOOL)animatedb{
    
    [self.audioPlayer stop];
}

-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"2dde4c532409388b050d185c56ce9051.mp3" ofType:nil];
        NSURL *url=[NSURL fileURLWithPath:urlStr];
        NSError *error=nil;
        //初始化播放器，注意这里的Url参数只能时文件路径，不支持HTTP Url
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        //设置播放器属性
        _audioPlayer.numberOfLoops= -1;//设置为0不循环
//        _audioPlayer.delegate=self;
        [_audioPlayer prepareToPlay];//加载音频文件到缓存
        if(error){
            NSLog(@"初始化播放器过程发生错误,错误信息:%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
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
