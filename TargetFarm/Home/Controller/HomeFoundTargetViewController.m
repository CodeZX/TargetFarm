//
//  HomeFoundTargetViewController.m
//  TargetFarm
//
//  Created by apple on 2018/3/22.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "HomeFoundTargetViewController.h"
#import "HomeFoundTargetSelectBar.h"
#import "HomeAddPhaseViewController.h"
//#import "WSDatePickerView.h"
//#import "XHDatePickerView.h"
#import "HomeAddPhaseCell.h"
#import "ZXDatePickerView.h"

#define HEADER_HEIGHE   400
#define FOOTER_HEIGHE   0
#define CELL_HEIGHE     88
#define SELECTBAR_HEIGHE 44

#define DATE_FORMATTER(df)  NSDateFormatter *df  =   [NSDateFormatter new]; \
df.timeZone = [NSTimeZone systemTimeZone];\
df.dateFormat = @"YYYY-MM-dd HH:mm:ss";





@interface HomeFoundTargetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UILabel *targetNameLabel;
@property (nonatomic,weak) UITextField *targetNameTextField;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UIDatePicker *datePicker;
@property (nonatomic,weak) BasicTableView *tableView;
@property (nonatomic,strong) BasicView *tableHeaderView;


@property (nonatomic,strong) ZXDatePickerView *pickerView;
@property (nonatomic,strong) HomeFoundTargetSelectBar *startSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *endSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *awokeSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *phaseSelectBar;




//@property (nonatomic,strong) WSDatePickerView *datePickerView;
@end

@implementation HomeFoundTargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    
}


- (void)setupUI {
    
    self.title = @"创建目标";
    self.view.backgroundColor = WhiteColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(rigthClick:)];
    
    self.tableHeaderView = [BasicView new];
    self.tableHeaderView.frame = CGRectMake(0, 0, Screen_Width, 400);
   
    UILabel *targetNameLabel = [UILabel new];
    targetNameLabel.text = @"目标名称";
    [self.tableHeaderView addSubview:targetNameLabel];
    self.targetNameLabel = targetNameLabel;
    [self.targetNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableHeaderView).offset(25);
        make.left.equalTo(self.tableHeaderView).offset(20);
    }];


    UITextField *targetNameTextField = [UITextField new];
//    targetNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    targetNameTextField.placeholder = @"输入你的目标计划";
    [self.tableHeaderView addSubview:targetNameTextField];
    self.targetNameTextField = targetNameTextField;
    [self.targetNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tableHeaderView);
        make.top.equalTo(self.targetNameLabel.bottom).offset(30);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = BlackColor;
    [self.tableHeaderView addSubview:line];
    self.line = line;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.targetNameTextField.bottom).offset(5);
    }];

    [self addSelectBar];
    
    BasicTableView *tableView = [BasicTableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


// 取消
- (void)leftClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    TargetManage *targetManage = [TargetManage sharedTargetManage];
//    NSLog(@"%@",[targetManage getTarget]);
    
//    [self showSuccess:@"124"];
}

// 确定
- (void)rigthClick:(id)sender {
    
    
    TargetManage *targetManage = [TargetManage sharedTargetManage];
    if (![targetManage createDataBaseWithPath:nil])                                     { return; }
    if (![targetManage addTargetWithTargetModel:[self getTargetModelofCurrentlyController]])  { return; }

    
    
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
//    dateFormatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
//    DEBUG_LOG(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
//    TargetModel *model = [TargetModel new];
//    model.targetName = @"吃饭";
//    model.phaseTableName = @"lalal";
//    model.beginDate = [NSDate date];
//    model.endDate = [NSDate date];
    
    
   
    
}



- (TargetModel *)getTargetModelofCurrentlyController {
    
    DATE_FORMATTER(df)
    TargetModel *targetModel = [TargetModel new];
    targetModel.targetName = self.targetNameLabel.text;
    targetModel.beginDate = [df dateFromString:self.startSelectBar.content];
    targetModel.endDate = [df dateFromString:self.endSelectBar.content];
    targetModel.awokeDate= [df dateFromString:self.awokeSelectBar.content];
    targetModel.phaseTableName = @"";
    targetModel.awoke = NO;
    return targetModel;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)addSelectBar {
   
    
    Weak_Self(weakSelf);
    
    
    
    self.startSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"起始日期" ImagName:nil Action:^{
        
        NSLog(@"起始日期");

        
        weakSelf.pickerView = [[ZXDatePickerView alloc]initWithAction:^(NSDate *date) {
            
            DATE_FORMATTER(df)
            weakSelf.startSelectBar.content = [df stringFromDate:date];
            [weakSelf.pickerView removeFromSuperview];
//
        }];
        weakSelf.pickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:weakSelf.pickerView];
        

        
    }];
    [self.tableHeaderView addSubview:self.startSelectBar];
    [self.startSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(self.line.bottom).offset(50);
             make.left.equalTo(20);
             make.right.equalTo(-20);
             make.height.equalTo(SELECTBAR_HEIGHE);
        }];
    
    



    
   self.endSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"截止日期" ImagName:nil Action:^{

            NSLog(@"截止日期");
           weakSelf.pickerView = [[ZXDatePickerView alloc]initWithAction:^(NSDate *date) {
               
           DATE_FORMATTER(df)
           weakSelf.endSelectBar.content = [df stringFromDate:date];
           [weakSelf.pickerView removeFromSuperview];
           //
       }];
       weakSelf.pickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
       [self.view addSubview:weakSelf.pickerView];

    }];


    [self.tableHeaderView addSubview:self.endSelectBar];
    [self.endSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];


    self.awokeSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"提醒" ImagName:nil Action:^{

               NSLog(@"提醒");
           weakSelf.pickerView = [[ZXDatePickerView alloc]initWithAction:^(NSDate *date) {
            
            DATE_FORMATTER(df)
            weakSelf.awokeSelectBar.content = [df stringFromDate:date];
            [weakSelf.pickerView removeFromSuperview];
            //
        }];
        weakSelf.pickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:weakSelf.pickerView];

    }];

    [self.tableHeaderView addSubview:self.awokeSelectBar];
    [self.awokeSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];



    self.phaseSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"阶段" ImagName:@"anniu" Action:^{


            HomeAddPhaseViewController *addPhaseVC = [HomeAddPhaseViewController new];
            [self.navigationController pushViewController:addPhaseVC animated:YES];

        }];


    [self.tableHeaderView addSubview:self.phaseSelectBar];
    [self.phaseSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.awokeSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];


}


- (void)seletedBirthyDate {
    
    
    
//    获取系统当前时间
    NSDate *currentDate = [NSDate date];
//    用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:self.datePicker.date];
    NSLog(@"%@",currentDateString);
    
}

#pragma mark -------------------------- table delegate ----------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CELL_HEIGHE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
     HomeAddPhaseCell *cell = [HomeAddPhaseCell cellWithTableView:tableView Identifier:@"cell"];
//    cell.textLabel.text = @"阶段";
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
