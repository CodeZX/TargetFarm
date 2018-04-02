//
//  HomeMyTargetController.m
//  TargetFarm
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeMyTargetController.h"
#import "HomeAddPhaseCell.h"
#import "HomeFoundTargetViewController.h"


@interface HomeMyTargetController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UILabel *targetNameLabel;
@property (nonatomic,weak) BasicTableView *tableView;
@end

@implementation HomeMyTargetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}



- (void)setupUI  {
    
    self.title = @"我的目标";
    self.view.backgroundColor = MotifColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(rightBtnClick:)];
    
    
    
    UILabel *targetNameLabel = [UILabel new];
    targetNameLabel.font = [UIFont systemFontOfSize:FONT_SIZE_BIG];
    targetNameLabel.textColor = UIColorFromRGB(0x353535);
//    targetNameLabel.backgroundColor = RedColor;
    if (self.targerModel) {
       targetNameLabel.text = self.targerModel.targetName;
    }
    
    [self.view addSubview:targetNameLabel];
    self.targetNameLabel = targetNameLabel;
    [self.targetNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
//        make.height.equalTo(100);
        
    }];
    
    
    DEBUG_LOG(@"%@",self.targetNameLabel);
    
    
    
    BasicTableView *tableView = [BasicTableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = MotifColor;
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.targetNameLabel.bottom).offset(30);
        make.left.right.bottom.equalTo(0);
    }];
}


- (void)rightBtnClick:(id)sender {
    
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"删除目标" style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                             
                                                             TargetManage *TM = [TargetManage sharedTargetManage];
                                                             if (![TM deleteTarget:self.targerModel]) {
                                                                 
                                                                 DEBUG_LOG(@"删除失败");
                                                                 return;
                                                             }
                                                              DEBUG_LOG(@"删除成功");
                                                             [self.navigationController popViewControllerAnimated:YES];
                                                         }];
    UIAlertAction* modificationAction = [UIAlertAction actionWithTitle:@"修改目标" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   //响应事件
                                                                   NSLog(@"action = %@", action);
                                                                   
                                                                   HomeFoundTargetViewController *VC = [[HomeFoundTargetViewController alloc]initWithTargetModel:self.targerModel];
                                                                   [self.navigationController pushViewController:VC animated:YES];
                                                                   
                                                                   
                                                               }];
    
    UIAlertAction* abandonAction = [UIAlertAction actionWithTitle:@"放弃目标" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                          }];
    [alert addAction:modificationAction];
    [alert addAction:cancelAction];
    [alert addAction:abandonAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.targerModel.phaseAry.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HomeAddPhaseCell *cell = [HomeAddPhaseCell cellWithTableView:tableView Identifier:@"cell"];
    //    cell.textLabel.text = @"阶段";
    TargetPhaseModel *model = self.targerModel.phaseAry[indexPath.row];
    cell.targetPhaseModel = model;
    cell.title = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
    
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
