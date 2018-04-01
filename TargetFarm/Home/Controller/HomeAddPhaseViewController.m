//
//  HomeAddPhaseViewController.m
//  TargetFarm
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeAddPhaseViewController.h"
#import "ZXDatePickerView.h"
#import "HomeFoundTargetSelectBar.h"


#define HEADER_HEIGHE   400
#define FOOTER_HEIGHE   0
#define CELL_HEIGHE     88
#define SELECTBAR_HEIGHE 44

#define DATE_FORMATTER(df)  NSDateFormatter *df  =   [NSDateFormatter new]; \
df.timeZone = [NSTimeZone systemTimeZone];\
df.dateFormat = @"YYYY-MM-dd HH:mm:ss";

typedef NS_ENUM(NSInteger, TapPhaseBarStyle) {
    TapPhaseBarStyleStartSelectBar = 0,
    TapPhaseBarStyleEndSelectBar,
    TapPhaseBarStyleAwokeSelectBar
};


@interface HomeAddPhaseViewController ()

@property (nonatomic,weak) UILabel *targetNameLabel;
@property (nonatomic,weak) UITextField *targetNameTextField;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,strong) UIDatePicker *datePicker;

@property (nonatomic,strong) ZXDatePickerView *pickerView;
@property (nonatomic,strong) HomeFoundTargetSelectBar *startSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *endSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *awokeSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *phaseSelectBar;

@property (nonatomic,assign) TapPhaseBarStyle tapPhaseBarStyle;
@property (nonatomic,strong) TargetPhaseModel *targetPhaseModel;
@end

@implementation HomeAddPhaseViewController

- (instancetype)initWithPhaseModel:(TargetPhaseModel *)phaseModel {
    
    self = [super init];
    if (self) {
        
        self.targetPhaseModel = phaseModel;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI  {
    
    
    self.title = @"增加阶段";
    self.view.backgroundColor = MotifColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnClick:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    

    UILabel *targetNameLabel = [UILabel new];
    targetNameLabel.text = @"目标名称";
    targetNameLabel.textColor = UIColorFromRGB(0x28282a);
    targetNameLabel.font = FONT_PT_FROM_PX(20);
    [self.view addSubview:targetNameLabel];
    self.targetNameLabel = targetNameLabel;
    [self.targetNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(25);
        make.left.equalTo(self.view).offset(20);
    }];
    
    
    UITextField *targetNameTextField = [UITextField new];
    //    targetNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    targetNameTextField.placeholder = @"输入你的目标计划";
    [targetNameTextField setFont:FONT_PT_FROM_PX(26)];
    targetNameTextField.text = self.targetPhaseModel.content;
    [targetNameTextField setTextColor:UIColorFromRGB(0x969797)];
    [self.view addSubview:targetNameTextField];
    self.targetNameTextField = targetNameTextField;
    [self.targetNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.targetNameLabel.bottom).offset(30);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xe7dfc5);
    [self.view addSubview:line];
    self.line = line;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.targetNameTextField.bottom).offset(5);
    }];
    
    
    UIDatePicker  *datePicker = [UIDatePicker new];
    datePicker.backgroundColor = WhiteColor;
    datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_ch"];
    // 设置时区，中国在东八区
    //    datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [datePicker addTarget:self action:@selector(seletedBirthyDate:) forControlEvents:UIControlEventValueChanged];
    self.datePicker = datePicker;
    datePicker.frame = CGRectMake(0, 0, SCREEN_WIDTH, 216);
    
    [self addSelectBar];
}

- (void)seletedBirthyDate:(UIDatePicker *)datePicker {
    
    DATE_FORMATTER(df)

    switch (self.tapPhaseBarStyle) {
        case TapPhaseBarStyleStartSelectBar:
                self.startSelectBar.content = [df stringFromDate:datePicker.date];
            break;
        case TapPhaseBarStyleEndSelectBar:
            self.endSelectBar.content = [df stringFromDate:datePicker.date];
            break;
        case TapPhaseBarStyleAwokeSelectBar:
            self.awokeSelectBar.content = [df stringFromDate:datePicker.date];
            break;
        default:
            break;
    }
    

}
- (void)cancelClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)rightBtnClick:(id)sender {
    

    [self showSaving];
    DEBUG_LOG(@"保存");
    TargetManage *targetManage = [TargetManage sharedTargetManage];
    NSString *phaseTableName = [targetManage createPhaseTable];
    if ([phaseTableName isEqualToString:@""]) { DEBUG_LOG(@"创建失败");return;}
    DEBUG_LOG(@"创建成功");
    NSLog(@"%@",phaseTableName);
    
   BOOL result =  [targetManage addPhaseWithPhase:[self getTargetPhaseModelofCurrentlyController] PhaseName:phaseTableName];
   if (!result) {  DEBUG_LOG(@"插入失败"); return; }
   DEBUG_LOG(@"插入成功");
    
    
    if ([self.delegate respondsToSelector:@selector(homeAddPhase:didAddInPhase:)]) {
         [self.delegate homeAddPhase:self didAddInPhase:phaseTableName];
    }
   
    [NSTimer scheduledTimerWithTimeInterval:1.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [self hideHUD];
        [self showMessage:@"保存成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
}


- (void)addSelectBar {
    
    Weak_Self(weakSelf);
    DATE_FORMATTER(df)
    self.startSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"起始日期" ImagName:nil Action:^{
        
        NSLog(@"起始日期");
        self.tapPhaseBarStyle = TapPhaseBarStyleStartSelectBar;
        [weakSelf showDatePicker];
        
    }];
    self.startSelectBar.content = [df stringFromDate:self.targetPhaseModel.beginDate];
    [self.view addSubview:self.startSelectBar];
    [self.startSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.bottom).offset(50);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];
    

    self.endSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"截止日期" ImagName:nil Action:^{
        
        NSLog(@"截止日期");
        self.tapPhaseBarStyle = TapPhaseBarStyleEndSelectBar;
        [weakSelf showDatePicker];
    }];
    self.endSelectBar.content = [df stringFromDate:self.targetPhaseModel.endDate];
    [self.view addSubview:self.endSelectBar];
    [self.endSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];
    
    
    self.awokeSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"提醒" ImagName:nil Action:^{
        
        NSLog(@"提醒");
        self.tapPhaseBarStyle = TapPhaseBarStyleAwokeSelectBar;
        [weakSelf showDatePicker];
    }];
    [self.view addSubview:self.awokeSelectBar];
    self.awokeSelectBar.content = [df stringFromDate:self.targetPhaseModel.awokeDate];
    [self.awokeSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];
    
    
    

    
    
}

- (TargetPhaseModel *)getTargetPhaseModelofCurrentlyController {
    
    DATE_FORMATTER(df)
    TargetPhaseModel *targetPhaseModel = [TargetPhaseModel new];
    targetPhaseModel.title = @"阶段";
    targetPhaseModel.content = self.targetNameTextField.text;
    targetPhaseModel.beginDate = [df dateFromString:self.startSelectBar.content];
    targetPhaseModel.endDate = [df dateFromString:self.endSelectBar.content];
    targetPhaseModel.awokeDate= [df dateFromString:self.awokeSelectBar.content];
    targetPhaseModel.accomplish = 0;
    return targetPhaseModel;
    
}

- (void)showDatePicker {
    
    [self.targetNameTextField  resignFirstResponder];
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker showInController:self preferredStyle:TYAlertControllerStyleActionSheet backgoundTapDismissEnable:YES];
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
