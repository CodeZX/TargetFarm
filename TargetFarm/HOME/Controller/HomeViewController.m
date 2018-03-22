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

#import "TargetModel.h"



@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomeTableSectionHeadViewDelegate>
@property (nonatomic,weak) HomeTableView *homeTableView;
@property (nonatomic,strong) NSMutableArray *targetAry;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self getData];
}


- (void)setupUI {
    
    self.title = @"首页";
    
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightClick:)];
    
    
    HomeTableView *homeTableView = [HomeTableView new];
    homeTableView.dataSource = self;
    homeTableView.delegate = self;
    [self.view addSubview:homeTableView];
    self.homeTableView = homeTableView;
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.size.equalTo(self.view);
    }];
    
    
}

- (void)rightClick:(id )sender {
    
    
}
- (void)getData {
    
//    NSMutableArray *targetAry = [NSMutableArray new];
//    self.targetAry = targetAry;
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -------------------------- table delegate ----------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.targetAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TargetModel *targetModel = self.targetAry[section];
    return targetModel.unfold ? targetModel.scheduleAry.count:0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [HomeTableViewCell cellWithTableView:tableView Identifier:@"homeTableView"];
    TargetModel *targetModel = self.targetAry[indexPath.section];
    TargetScheduleModel *targetScheduleModel = targetModel.scheduleAry[indexPath.row];
    cell.targetScheduleModel = targetScheduleModel;
//    cell.textLabel.text = @"首页";
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
    HomeTableSectionHeadView *headView = [HomeTableSectionHeadView new];
    headView.delegate = self;
    headView.frame = CGRectMake(0, 0, Screen_Width, 0);
    TargetModel *targetModel = self.targetAry[section];
    targetModel.section = section;
    headView.targetModel = targetModel;
    
    
    return headView;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
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

- (NSMutableArray *)targetAry {
    
    if (!_targetAry) {
        
        _targetAry = [NSMutableArray new];
        TargetModel *model1 =  [TargetModel new];
        model1.targetStr = @"早上 6：00 去跑步";
        [_targetAry addObject:model1];
        
        TargetModel *model2 =  [TargetModel new];
        model2.targetStr = @"早上 7：00 早读";
        [_targetAry addObject:model2];
        
        TargetModel *model3 =  [TargetModel new];
        model3.targetStr = @"上午11：00 开会";
        [_targetAry addObject:model3];
        
        TargetModel *model4 =  [TargetModel new];
        model4.targetStr = @"中午12：00 午饭";
        [_targetAry addObject:model4];
        
        TargetModel *model5 =  [TargetModel new];
        model5.targetStr = @"下午1：00 整理文件";
        [_targetAry addObject:model5];
        
        TargetModel *model6 =  [TargetModel new];
        model6.targetStr = @"下午7：00 聚会";
        [_targetAry addObject:model6];
    }
    
    return _targetAry;
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
