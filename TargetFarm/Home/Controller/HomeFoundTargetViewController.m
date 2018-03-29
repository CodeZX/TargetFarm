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





@interface HomeFoundTargetViewController ()<UITableViewDelegate,UITableViewDataSource,HomeAddPhaseDelegate>
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

@property (nonatomic,strong) TargetModel *targetModel;
@property (nonatomic,strong) NSArray *phaseAry;


//@property (nonatomic,strong) WSDatePickerView *datePickerView;
@end


@implementation HomeFoundTargetViewController
{
    
    TargetManage *TM;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.targetModel = [TargetModel new];
    TM = [TargetManage sharedTargetManage];
    [self setupUI];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    if (!self.targetModel.phaseTableName) { return ;}
   self.phaseAry  = [TM allPhaseFromPhaseName:self.targetModel.phaseTableName];
    [self.tableView reloadData];
}

- (void)setupUI {
    
    self.title = @"创建目标";
    self.view.backgroundColor = MotifColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(rigthClick:)];
    
    self.tableHeaderView = [BasicView new];
    self.tableHeaderView.backgroundColor = ClearColor;
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
    tableView.backgroundColor = MotifColor;
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
    if ([self.targetModel.phaseTableName isEqualToString:@""]) { return;}
  
        
        // 删除phaae
        TargetManage *TM = [TargetManage sharedTargetManage];
        if (![TM deletePhaseTableWithPhaseName:self.targetModel.phaseTableName]) { DEBUG_LOG(@"删除失败"); }

        DEBUG_LOG(@"删除成功");
    
    
//    TargetManage *targetManage = [TargetManage sharedTargetManage];
//    NSLog(@"%@",[targetManage getTarget]);
    
//    [self showSuccess:@"124"];
}

// 确定
- (void)rigthClick:(id)sender {
    
    
    TargetManage *targetManage = [TargetManage sharedTargetManage];
//    if (![targetManage createDataBaseWithPath:nil])                                     { return; }
    if (![targetManage addTargetWithTargetModel:[self getTargetModelofCurrentlyController]])  { return; }

    [self showSuccess:@"新建成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    self.targetModel = [TargetModel new];
    self.targetModel.targetName = self.targetNameTextField.text;
    self.targetModel.beginDate = [df dateFromString:self.startSelectBar.content];
    self.targetModel.endDate = [df dateFromString:self.endSelectBar.content];
    self.targetModel.awokeDate= [df dateFromString:self.awokeSelectBar.content];
    self.targetModel.phaseTableName = @"";
    self.targetModel.awoke = NO;
    return self.targetModel;
    
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
    [self.tableHeaderView addSubview:self.startSelectBar];
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


    [self.tableHeaderView addSubview:self.endSelectBar];
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

    [self.tableHeaderView addSubview:self.awokeSelectBar];
    [self.awokeSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];



    self.phaseSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"阶段" ImagName:@"anniu" Action:^{


            HomeAddPhaseViewController *addPhaseVC = [HomeAddPhaseViewController new];
            addPhaseVC.delegate = self;
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
    
    return self.phaseAry.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CELL_HEIGHE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
     HomeAddPhaseCell *cell = [HomeAddPhaseCell cellWithTableView:tableView Identifier:@"cell"];
//    cell.textLabel.text = @"阶段";
    return cell;
    
}

- (void)homeAddPhase:(HomeAddPhaseViewController *)homeAddPhase didAddInPhase:(NSString *)phase {
    
//    // 更新
//    DEBUG_LOG(@"%@",phase);
//
//    TargetManage *TM= [TargetManage sharedTargetManage];
//
//    BOOL result =[TM updateTargetWithPrimaryKey:3 Option:@{@"PhaseName":phase}];
//    if (!result) { DEBUG_LOG(@"更新失败");return ; }
//    DEBUG_LOG(@"更新成功");
    
    
    self.targetModel.phaseTableName = phase;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//     [self.targetNameTextField  resignFirstResponder];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
