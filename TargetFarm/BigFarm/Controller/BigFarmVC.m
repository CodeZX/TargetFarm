//
//  BigFarmVC.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "BigFarmVC.h"
#import "FarmScene.h"
#import "myApi.h"
#import "TargetModel.h"
#import "BigFarmScene.h"

@interface BigFarmVC ()
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,weak) NSArray *targetAty;
@property (nonatomic,strong) SKView *skview;
@end

@implementation BigFarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MotifColor;
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:@"获取" style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClick:)];
   
    
  

    
}

- (void)rightBtnClick:(UIButton *)btn {
    
    BigFarmScene *scene = (BigFarmScene *) self.skview.scene;
    TargetModel *targetModel = [scene getTargetModel];
    TargetManage *TM= [TargetManage sharedTargetManage];
    
    DEBUG_LOG(@"%@",targetModel);
    
    NSString * phaseName = [NSString stringWithFormat:@"t_phase_%@",[NSString jk_UUIDTimestamp]];
    
    
    NSString *phaseTableName = [TM createPhaseTableWithPhaseName:phaseName
                                ];
    if (phaseTableName) {
        
        
        for (TargetPhaseModel *model in targetModel.phaseAry) {
            
//            model.title = @"";
//            model.beginDate = [NSDate new];
//            model.endDate = [NSDate new];
            model.awokeDate = [NSDate new];
            model.accomplish = 0;
        }
        if ([TM addPhaseAryWithAry:targetModel.phaseAry PhaseName:phaseTableName]) {
           
            targetModel.phaseTableName = phaseTableName;
            if ([TM addTargetWithTargetModel:[self targetModelInit:targetModel]]) {
                
                        [self showMessage:@"获取成功，可到首页查看"];
                
            };
        }
    }
    
   
    
    
    
}

- (TargetModel *)targetModelInit:(TargetModel *)targerModel {
    
    targerModel.targetName = targerModel.targetName ? targerModel.targetName:@"";
//    targerModel.endDate = [NSDate new];
//    targerModel.beginDate = [NSDate new];
    targerModel.awokeDate = [NSDate new];
    targerModel.phaseTableName  = targerModel.phaseTableName? targerModel.phaseTableName:@"";
    return targerModel;
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [self.audioPlayer play];
    
    myApi *api = [[myApi alloc]initWithCity:@"北京"];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        
        //        self.targetAty =
        
        self.targetAty = [TargetModel mj_objectArrayWithKeyValuesArray:request.responseObject];
        
        
        DEBUG_LOG(@"%@",request.responseString);
        
        self.skview = [[SKView alloc] initWithFrame:self.view.bounds];
        //    MyScene *scene = [MyScene sceneWithSize:skView.bounds.size];
        BigFarmScene   *scene = [[BigFarmScene alloc]initWithTargetAry:self.targetAty NonceTargetModel:self.targetAty[0]];
        
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene
        [self.skview presentScene:scene];
        
        self.skview.showsFPS = YES;
        self.skview.showsNodeCount = YES;
        self.view = self.skview;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
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
