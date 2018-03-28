
//
//  HomeTableViewCell.m
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeTableCellContainerView.h"

@interface HomeTableViewCell ()
@property (nonatomic,weak) UILabel *contentLable;
@property (nonatomic,weak) UIImageView *backgroundImg;
@property (nonatomic,weak) HomeTableCellContainerView *containerView;
@property (nonatomic,weak) UIImageView *tagImg;

@end
@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView Identifier:(NSString *)Identifier {
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (!cell) {
        
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
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

- (void)setupUI {
    
    self.contentView.backgroundColor = MotifColor;
   
    
    
    HomeTableCellContainerView *containerView = [HomeTableCellContainerView new];
    [self.contentView addSubview:containerView];
    self.containerView = containerView;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
//    UIImageView *backgroundImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing22"]];
//    [self.containerView addSubview:backgroundImg];
//    self.backgroundImg = backgroundImg;
//    [self.backgroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(0);
//    }];
//
//    UIImageView *tagImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"beijing1"]];
//    [self.containerView addSubview:tagImg];
//    self.tagImg = tagImg;
//    [self.tagImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(UIEdgeInsetsMake(30, 30, 30, 30));
//    }];
//
//    UILabel *contentLable = [UILabel new];
////    contentLable.backgroundColor = RandomColor;
//    contentLable.textColor = RandomColor;
//    [self.containerView addSubview:contentLable];
//    self.contentLable = contentLable;
////    self.contentLable.text    = @"1111";
//    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.containerView);
//
//    }];
    
    
    
}

- (void)setTargetModel:(TargetModel *)targetModel {
    
    _targetModel = targetModel;
    self.containerView.targetModel = targetModel;
}

- (void)setTargetScheduleModel:(TargetScheduleModel *)targetScheduleModel {
    
    _targetScheduleModel = targetScheduleModel;
//    self.contentLable.text = _targetScheduleModel.contentStr;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
