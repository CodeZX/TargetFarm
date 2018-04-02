//
//  HomeAddPhaseCell.m
//  TargetFarm
//
//  Created by apple on 2018/3/23.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeAddPhaseCell.h"


@interface HomeAddPhaseCell ()

@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UILabel *contentLable;
@property (nonatomic,weak) UIView *line;

@end
@implementation HomeAddPhaseCell
+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)Identifier {
    
    HomeAddPhaseCell  *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (!cell) {
        
        cell = [[HomeAddPhaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = ClearColor;
        
    }
    
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI  {
    
    
   
    
    UIView *bagView = [UIView new];
    bagView.backgroundColor = WhiteColor;
    bagView.layer.cornerRadius = 5;
    bagView.layer.masksToBounds = YES;
    [self.contentView addSubview:bagView];
    [bagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(15, 15, 15, 15));
                           }];
   
    UILabel *titleLabel = [UILabel new];
    titleLabel.text  = @"阶段";
    titleLabel.textColor = UIColorFromRGB(0x706f6d);
//    titleLabel.backgroundColor = RandomColor;
    
    [self.contentView addSubview:titleLabel];
    self.titleLable = titleLabel;
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(D_INTERVAL_LEFT * 3);
//        make.top.equalTo(D_INTERVAL);
        make.centerY.equalTo(self.contentView);
    }];
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text  = @"苍山普洱5日游";
    contentLabel.textColor = UIColorFromRGB(0x706f6d);
    [self.contentView addSubview:contentLabel];
    self.contentLable = contentLabel;
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {

        make.center.equalTo(self.contentView);
//        make.center.equalTo(self.contentView);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0x706f6d);
    [self.contentView addSubview:line];
    self.line = line;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.top.equalTo(self.contentLable.bottom).offset(D_INTERVAL);
        make.left.equalTo(titleLabel.right);
        make.right.equalTo(bagView.right).offset(-30);
    }];
    
}

- (void)setTargetPhaseModel:(TargetPhaseModel *)targetPhaseModel {
    
    _targetPhaseModel = targetPhaseModel;
    self.contentLable.text = targetPhaseModel.content;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.titleLable.text = [NSString stringWithFormat:@"阶段 %@",title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
