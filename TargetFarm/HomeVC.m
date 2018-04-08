//
//  HomeVC.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeVC.h"
#import "HomeCellModel.h"
#import "HomeSubCellModel.h"



@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    HomeCellModel *model1 = [HomeCellModel new];
    model1.isRegisterXib = YES;
    
    
    HomeCellModel *model2 = [HomeCellModel new];
    model2.isRegisterXib = YES;
    
    HomeSubCellModel *sub1 = [HomeSubCellModel new];
    sub1.isRegisterXib = YES;
    model2.subTabViewSectionArray = @[sub1];
    
//    HomeCellModel *model3 = [HomeCellModel new];
//    model3.subCellArray = @[[HomeSubCellModel new], [HomeSubCellModel new]];
    
    
    CommonSectionModel *section = [CommonSectionModel new];
    section.modelArray = @[[self cell1], [self cell2], [self cell3]];

//    section.modelArray = @[[self cell1], [self cell1], [self cell1], [self cell1]];
    
    self.tableViewTool.dataArr = @[section];
    [self.tableView reloadData];
    
    
    
}


- (HomeCellModel *)cell1 {
    HomeCellModel *model = [HomeCellModel new];
    model.isRegisterXib = YES;
    return model;
}


- (HomeCellModel *)cell2 {
    HomeCellModel *model = [HomeCellModel new];
    model.isRegisterXib = YES;
    
    
    HomeSubCellModel *sub = [HomeSubCellModel new];
    sub.isRegisterXib = YES;
    sub.title = @"欧洲30日游";
    sub.subTitle = @"7月1日前";
    
    CommonSectionModel *subSection = [CommonSectionModel new];
    subSection.modelArray = @[sub];
    model.subTabViewSectionArray = @[subSection];
    return model;
}

- (HomeCellModel *)cell3 {
    HomeCellModel *model = [HomeCellModel new];
    model.isRegisterXib = YES;
    
    
    HomeSubCellModel *sub = [HomeSubCellModel new];
    sub.isRegisterXib = YES;
    sub.title = @"欧洲30日游";
    sub.subTitle = @"7月1日前";
    
    HomeSubCellModel *sub2 = [HomeSubCellModel new];
    sub2.isRegisterXib = YES;
    sub2.title = @"火星5日游";
    sub2.subTitle = @"5月1日前";
    
    CommonSectionModel *subSection = [CommonSectionModel sectionWithModelArray:@[sub, sub2, sub2, sub2]];
    
    model.subTabViewSectionArray = @[subSection];
    
    return model;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 点击subTableView (也就是cell里面的UITableView的cell触发)
- (void)tableView:(UITableView *_Nullable)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row model:(CommonTableViewCellModel *_Nullable)cellModel tableViewTool:(CommonTableViewTool *_Nonnull)tool {
    HomeCellModel *model = (HomeCellModel *)cellModel;
    
    NSLog(@"主 TableView 点击 第%ld行     %@ ", row, model.openSubTabView ? @"打开子视图" : @"关闭子视图");
    [tableView reloadData];
}



@end
