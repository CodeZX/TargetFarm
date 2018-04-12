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
#import "myApi.h"
#import "BigFarmScene.h"

@interface MyFarmVC ()
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) NSMutableArray *targetAry;
@property (nonatomic,strong) SKView *skView;
@property (nonatomic,strong) NSMutableArray *longTargetAry;
@end

@implementation MyFarmVC
{
    
    TargetManage *TM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TM = [TargetManage sharedTargetManage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"phaseModel" object:nil];
    
    [self setupUI];
}

- (void)setupUI {
    
    //先生成存放标题的数据
    NSArray *array = [NSArray arrayWithObjects:@"我的农场",@"大农场", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    //设置frame
    segment.frame = CGRectMake(10, 100, self.view.frame.size.width/2, 30);
    segment.selectedSegmentIndex = 0;
      [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
    
    
    
    
    
}

-(void)change:(UISegmentedControl *)sender{
  
    if (sender.selectedSegmentIndex == 0) {
        [self showMyFarm];
    }else if (sender.selectedSegmentIndex == 1){
        [self showBigFarm];
    }
}

- (void)showBigFarm {
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"dasnongchang"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"获取" style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClick:)];
    [self showLoading];
    myApi *api = [[myApi alloc]initWithCity:@"北京"];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        
        [self hideHUD];

        self.longTargetAry = [TargetModel mj_objectArrayWithKeyValuesArray:request.responseObject];
        
        
        DEBUG_LOG(@"%@",request.responseString);
        BigFarmScene   *scene = [[BigFarmScene alloc]initWithTargetAry:self.longTargetAry NonceTargetModel:self.longTargetAry[0]];
        
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene
        SKTransition *transition = [SKTransition pushWithDirection:SKTransitionDirectionUp duration:1];
        [self.skView presentScene:scene transition:transition];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
    
}

- (void)showMyFarm {
    
    
    self.navigationItem.rightBarButtonItems = nil;
    self.targetAry = [TM allTarget];
    for (TargetModel *targerModel in self.targetAry) {
        
        targerModel.phaseAry  = [TM allPhaseFromPhaseName:targerModel.phaseTableName];
        
    }
    FarmScene *scene = [[FarmScene alloc]initWithTargetAry:self.targetAry NonceTargetModel:[self.targetAry firstObject ]];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
     SKTransition *transition = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:1];
    [self.skView presentScene:scene transition:transition];
    
}
- (void)rightBtnClick:(UIButton *)Btn {
    
    BigFarmScene *scene = (BigFarmScene *) self.skView.scene;
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
- (void)push:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    TargetModel *model = userInfo[@"phaseModel"];
    
     HomeMyTargetController *VC = [HomeMyTargetController new];
    VC.targerModel = model;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [self.audioPlayer play];
   
    
    self.targetAry = [TM allTarget];
    for (TargetModel *targerModel in self.targetAry) {
        
        targerModel.phaseAry  = [TM allPhaseFromPhaseName:targerModel.phaseTableName];
        
    }
    
    self.skView = [[SKView alloc] initWithFrame:self.view.bounds];
    FarmScene *scene = [[FarmScene alloc]initWithTargetAry:self.targetAry NonceTargetModel:[self.targetAry firstObject ]];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [self.skView presentScene:scene];
    
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    self.view = self.skView;
    
    
}

- (void)viewWillDisappear:(BOOL)animatedb{
    
    [self.audioPlayer stop];
//    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.skView removeFromSuperview];
    
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
