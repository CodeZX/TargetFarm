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

@interface HomeAddPhaseViewController ()

@property (nonatomic,weak) UILabel *targetNameLabel;
@property (nonatomic,weak) UITextField *targetNameTextField;
@property (nonatomic,weak) UIView *line;

@property (nonatomic,strong) ZXDatePickerView *pickerView;
@property (nonatomic,strong) HomeFoundTargetSelectBar *startSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *endSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *awokeSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *phaseSelectBar;

@end

@implementation HomeAddPhaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI  {
    
    
    self.title = @"增加阶段";
    self.view.backgroundColor = MotifColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(rightBtnClick:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    

    UILabel *targetNameLabel = [UILabel new];
    targetNameLabel.text = @"目标名称";
    [self.view addSubview:targetNameLabel];
    self.targetNameLabel = targetNameLabel;
    [self.targetNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(25);
        make.left.equalTo(self.view).offset(20);
    }];
    
    
    UITextField *targetNameTextField = [UITextField new];
    //    targetNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    targetNameTextField.placeholder = @"输入你的目标计划";
    [self.view addSubview:targetNameTextField];
    self.targetNameTextField = targetNameTextField;
    [self.targetNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.targetNameLabel.bottom).offset(30);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = BlackColor;
    [self.view addSubview:line];
    self.line = line;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.targetNameTextField.bottom).offset(5);
    }];
    
    [self addSelectBar];
}


- (void)cancelClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)rightBtnClick:(id)sender {
    

    DEBUG_LOG(@"保存");
    
}


- (void)addSelectBar {
    
    Weak_Self(weakSelf);
    self.startSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"起始日期" ImagName:nil Action:^{
        
        NSLog(@"起始日期");
        [self.targetNameTextField  resignFirstResponder];
        
        weakSelf.pickerView = [[ZXDatePickerView alloc]initWithAction:^(NSDate *date) {
            
            DATE_FORMATTER(df)
            weakSelf.startSelectBar.content = [df stringFromDate:date];
            [weakSelf.pickerView removeFromSuperview];
        }];
        weakSelf.pickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:weakSelf.pickerView];
        
        
        
    }];
    [self.view addSubview:self.startSelectBar];
    [self.startSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.bottom).offset(50);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];
    
    
    
    
    
    
    self.endSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"截止日期" ImagName:nil Action:^{
        
        NSLog(@"截止日期");
        [self.targetNameTextField  resignFirstResponder];
        weakSelf.pickerView = [[ZXDatePickerView alloc]initWithAction:^(NSDate *date) {
            
            DATE_FORMATTER(df)
            weakSelf.endSelectBar.content = [df stringFromDate:date];
            [weakSelf.pickerView removeFromSuperview];
            //
        }];
        weakSelf.pickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:weakSelf.pickerView];
        
    }];
    
    
    [self.view addSubview:self.endSelectBar];
    [self.endSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];
    
    
    self.awokeSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"提醒" ImagName:nil Action:^{
        
        NSLog(@"提醒");
        [self.targetNameTextField  resignFirstResponder];
        weakSelf.pickerView = [[ZXDatePickerView alloc]initWithAction:^(NSDate *date) {
            
            DATE_FORMATTER(df)
            weakSelf.awokeSelectBar.content = [df stringFromDate:date];
            [weakSelf.pickerView removeFromSuperview];
            //
        }];
        weakSelf.pickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:weakSelf.pickerView];
        
    }];
    
    [self.view addSubview:self.awokeSelectBar];
    [self.awokeSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];
    
    
    
//    self.phaseSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"阶段" ImagName:@"anniu" Action:^{
//        
//        
//        HomeAddPhaseViewController *addPhaseVC = [HomeAddPhaseViewController new];
//        [self.navigationController pushViewController:addPhaseVC animated:YES];
//        
//        
//        
//        
//    }];
//    
//    
//    [self.view addSubview:self.phaseSelectBar];
//    [self.phaseSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.awokeSelectBar.bottom).offset(10);
//        make.left.equalTo(20);
//        make.right.equalTo(-20);
//        make.height.equalTo(SELECTBAR_HEIGHE);
//    }];
    
    
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
