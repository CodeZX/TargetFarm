//
//  HomeViewController.m
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableView.h"
#import "HomeTableViewCell.h"
#import "HomeTableSectionHeadView.h"
#import "HomeFoundTargetView.h"
#import "HomeFoundTargetViewController.h"
#import "HomeMyTargetController.h"

#import "TargetModel.h"
#import <AVFoundation/AVFoundation.h>


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeTableSectionHeadViewDelegate>
@property (nonatomic,weak) HomeTableView *homeTableView;
@property (nonatomic,strong) NSMutableArray *targetAry;
@property (nonatomic,strong) AVAudioPlayer *bgmPlayer;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"MainBGM" withExtension:@"mp3"];
//    self.bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
////    NSString *bgmPath = [[NSBundle mainBundle] pathForResource:@"Afternoon_Zoom" ofType:@"wav"];
////    self.bgmPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:bgmPath] error:NULL];
//    self.bgmPlayer.numberOfLoops = -1;
//    [self.bgmPlayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"update" object:nil];
    [self setupUI];
    [self getData];
}

- (void)reloadData:(NSNotification *)notification {
    
    HomeTableViewCell *cell = [notification.userInfo valueForKey:@"cell"];
    NSIndexPath *indexpath = [self.homeTableView indexPathForCell:cell];
    TargetModel *targetModel = self.targetAry[indexpath.row];
    if (targetModel.unfold) {
        
         [self.homeTableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationBottom];
    }else {
        
         [self.homeTableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationTop];
    }
   

}

- (void)setupUI {
    
    self.title = @"首页";
    
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightClick:)];
    
    
    HomeTableView *homeTableView = [HomeTableView new];
    homeTableView.dataSource = self;
    homeTableView.delegate = self;
    homeTableView.separatorStyle = UITableViewCellEditingStyleNone;
    homeTableView.backgroundColor= MotifColor;
    [self.view addSubview:homeTableView];
    self.homeTableView = homeTableView;
//    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(0);
//        make.left.equalTo(0);
//        make.size.equalTo(self.view);
//    }];
    self.homeTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
    self.homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.homeTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData {
    
    DEBUG_LOG(@"加载数据");
     TargetManage *targetManage = [TargetManage sharedTargetManage];
    self.targetAry = [targetManage allTarget];
    [self.homeTableView.mj_header endRefreshing];
//    if (self.targetAry.count == 0) {  DEBUG_LOG(@"暂无目标");return; }
    for (TargetModel *targerModel in self.targetAry) {
        
        targerModel.phaseAry  = [targetManage allPhaseFromPhaseName:targerModel.phaseTableName];
        
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"1234" object:nil];
    [self.homeTableView reloadData];
    
    
    

}

- (void)loadMoreData {
    
    DEBUG_LOG(@"加载数据");
    [self.homeTableView.mj_header endRefreshing];
    [self.homeTableView.mj_footer endRefreshing];
}
- (void)rightClick:(id )sender {
    
    HomeFoundTargetViewController *foundTargetVC = [HomeFoundTargetViewController new];
//    BasicNavigationController *NavVC = [[BasicNavigationController alloc]initWithRootViewController:foundTargetVC];
//    [self presentViewController:NavVC animated:YES completion:nil] ;
//
    [self.navigationController pushViewController:foundTargetVC animated:YES];
   
}
- (void)getData {
    
    [self.homeTableView.mj_header beginRefreshing];
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -------------------------- table delegate ----------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    TargetModel *targetModel = self.targetAry[section];
//    return targetModel.unfold ? targetModel.scheduleAry.count:0;
    
    return self.targetAry.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [HomeTableViewCell cellWithTableView:tableView Identifier:@"homeTableView"];
    TargetModel *targetModel = self.targetAry[indexPath.row];
    cell.targetModel = targetModel;
//    [UIView animateWithDuration:9 animations:^{
//        cell.transform =CGAffineTransformMakeTranslation(100, 0);
//    } completion:^(BOOL finished) {
////        cell.transform =CGAffineTransformIdentity;
//    }];
    
//    cell.transform =CGAffineTransformMakeScale(1, 2);
    

//    cell.targetScheduleModel = targetScheduleModel;
//    cell.textLabel.text = @"首页";
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    TargetModel *model = self.targetAry[indexPath.row];
//    if (!model.unfold) {
//
//        HomeTableViewCell *homeTableViewCell = (HomeTableViewCell *)cell;
//        [homeTableViewCell deletePhaseBar];
//    }
   
//    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
  

    HomeMyTargetController *myTargerVC = [HomeMyTargetController new];
    myTargerVC.targerModel = self.targetAry[indexPath.row];
    [self.navigationController pushViewController:myTargerVC animated:YES];
    

}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 100;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//
//
//    HomeTableSectionHeadView *headView = [HomeTableSectionHeadView new];
//    headView.delegate = self;
//    headView.frame = CGRectMake(0, 0, Screen_Width, 0);
//    TargetModel *targetModel = self.targetAry[section];
//    targetModel.section = section;
//    headView.targetModel = targetModel;
//
//
//    return headView;
//
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}


//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return @"删除";
//}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了。。%ld",indexPath.row);
//
//        // 收回左滑出现的按钮(退出编辑模式)
//        tableView.editing = NO;
//    }];
//    action0.backgroundColor = GrayColor;
//
//
//    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//        NSLog(@"删除。。%ld",indexPath.row);
//        tableView.editing = NO;
//    }];
//    action1.backgroundColor = RedColor;;
//
//    return @[action1, action0];
//
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//
//
//}
#pragma mark -------------------------- delegate ----------------------------------------
- (void)unfoldForSection:(NSInteger)section {
//    [self.homeTableView reloadData];
    [self.homeTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    NSLog(@"展开第%ld区",section);
}
#pragma mark -------------------------- lazy loading ----------------------------------------


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}



@end
