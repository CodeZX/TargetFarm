//
//  HomeCell.m
//  TargetFarm
//
//  Created by chenkaijie on 2018/3/7.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeCell.h"
#import "HomeSubCell.h"
#import "CommonTableViewTool.h"
#import "HomeCellModel.h"
#import "HomeSubCellModel.h"
#import "UITableViewCell+KJCategory.h"

@interface HomeCell () <CommonTableViewToolDelegate>

@property (strong, nonatomic) CommonTableViewTool *subTableViewTool;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subTabViewHeight;

@end

@implementation HomeCell

#define subTabView_rowHeight 90

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.subTableViewTool = [[CommonTableViewTool alloc] init];
    self.subTableViewTool.delegate = self;
    self.subTabView.dataSource = self.subTableViewTool;
    self.subTabView.delegate = self.subTableViewTool;
    self.subTabView.rowHeight = subTabView_rowHeight;
    self.subTableViewTool.tablView = self.subTabView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)openOrClose:(UIButton *)sender {
    
    HomeCellModel *model = (HomeCellModel *)self.cellModel;
    NSUInteger count = model.subTabViewSectionArray.firstObject.modelArray.count;
    if (count == 0) return;
    
    model.openSubTabView = !model.openSubTabView;
    [[self currentTableView] reloadData];
}

- (void)setupData:(CommonTableViewCellModel *)cellModel section:(NSInteger)section row:(NSInteger)row tableView:(UITableView *)tableView {
    HomeCellModel *model = (HomeCellModel *)self.cellModel;
    NSUInteger count = model.subTabViewSectionArray.firstObject.modelArray.count;
    BOOL openSubTabView = model.openSubTabView;
    
    if (openSubTabView == NO) { // 处于关闭状态
        if (self.subTabViewHeight.constant != 0) {
            self.subTabViewHeight.constant = 0;
        }
        
        return;
    }
    
    self.subTableViewTool.dataArr = model.subTabViewSectionArray;
    
    if (count == 0) {
        if (self.subTabViewHeight.constant != 0) {
            self.subTabViewHeight.constant = 0;
        }
//        NSLog(@"%@ ", @"000000000");
    } else if (count == 1) {
        if (self.subTabViewHeight.constant != subTabView_rowHeight) {
            self.subTabViewHeight.constant = subTabView_rowHeight;
            
        }
//        NSLog(@"%@ ", @"11111111");
    } else {
        if (self.subTabViewHeight.constant != subTabView_rowHeight * 2) {
            self.subTabViewHeight.constant = subTabView_rowHeight * 2;
            
        }
//        NSLog(@"%@ ", @"22222222");
    }
    
    NSLog(@"主  第%ld行 ", row);

    [self.subTabView reloadData];
}


#pragma mark - 点击subTableView (也就是cell里面的UITableView的cell触发)
- (void)tableView:(UITableView *_Nullable)tableView didSelectRowAtSection:(NSInteger)section row:(NSInteger)row model:(CommonTableViewCellModel *_Nullable)model tableViewTool:(CommonTableViewTool *_Nonnull)tool {
    NSLog(@"子 TableView 点击 第%ld行 ", row);
}





@end
