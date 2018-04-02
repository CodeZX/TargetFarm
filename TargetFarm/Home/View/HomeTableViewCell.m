
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

- (void)deletePhaseBar {
    
    [self.containerView deletePhaseBar];
    
}

@end
