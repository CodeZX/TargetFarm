
//
//  HomeTableViewCell.m
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeTableViewCell.h"


@interface HomeTableViewCell ()
@property (nonatomic,weak) UILabel *contentLable;

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
    
    self.backgroundColor = RandomColor;
    
    UILabel *contentLable = [UILabel new];
    contentLable.backgroundColor = RandomColor;
    contentLable.textColor = RandomColor;
    [self.contentView addSubview:contentLable];
    self.contentLable = contentLable;
    self.contentLable.text    = @"1111";
    [self.contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.height.equalTo(20);
        make.top.equalTo(10);
    }];
    
    
    
}

- (void)setTargetScheduleModel:(TargetScheduleModel *)targetScheduleModel {
    
    _targetScheduleModel = targetScheduleModel;
    self.contentLable.text = _targetScheduleModel.contentStr;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
