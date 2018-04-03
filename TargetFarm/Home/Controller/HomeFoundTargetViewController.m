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

typedef NS_ENUM(NSInteger, TapPhaseBarStyle) {
    TapPhaseBarStyleStartSelectBar = 0,
    TapPhaseBarStyleEndSelectBar,
    TapPhaseBarStyleAwokeSelectBar
};



@interface HomeFoundTargetViewController ()<UITableViewDelegate,UITableViewDataSource,HomeAddPhaseDelegate>
@property (nonatomic,weak) UILabel *targetNameLabel;
@property (nonatomic,weak) UITextField *targetNameTextField;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) BasicTableView *tableView;
@property (nonatomic,strong) BasicView *tableHeaderView;
@property (nonatomic,strong) UIDatePicker *datePicker;


@property (nonatomic,strong) ZXDatePickerView *pickerView;
@property (nonatomic,strong) HomeFoundTargetSelectBar *startSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *endSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *awokeSelectBar;
@property (nonatomic,strong) HomeFoundTargetSelectBar *phaseSelectBar;

@property (nonatomic,strong) TargetModel *targetModel;
@property (nonatomic,strong) TargetModel *editTargetModel;
@property (nonatomic,strong) NSArray *phaseAry;
@property (nonatomic,assign) TapPhaseBarStyle tapPhaseBarStyle;

//@property (nonatomic,strong) WSDatePickerView *datePickerView;
@end


@implementation HomeFoundTargetViewController
{
    
    TargetManage *TM;
}

- (instancetype)initWithTargetModel:(TargetModel *)targetModel {
    
    self = [super init];
    if (self) {
        
        self.editTargetModel = targetModel;
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.targetModel = [TargetModel new];
    TM = [TargetManage sharedTargetManage];
    self.phaseAry = [NSMutableArray new];
    [self setupUI];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
//    if (!self.targetModel.phaseTableName) { return ;}
    if (self.editTargetModel.phaseTableName ) {
        
         self.phaseAry = [TM allPhaseFromPhaseName:self.editTargetModel.phaseTableName];
    
    }else if (self.targetModel.phaseTableName) {
        
         self.phaseAry = [TM allPhaseFromPhaseName:self.targetModel.phaseTableName];
    }
  
    
    [self.tableView reloadData];
}

- (void)setupUI {
    
    self.title = self.editTargetModel? @"修改目标":@"创建目标";
    self.view.backgroundColor = MotifColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(rigthClick:)];
    
    self.tableHeaderView = [BasicView new];
    self.tableHeaderView.backgroundColor = ClearColor;
    self.tableHeaderView.frame = CGRectMake(0, 0, Screen_Width, 400);
   
    UILabel *targetNameLabel = [UILabel new];
    targetNameLabel.text = @"目标名称";
    targetNameLabel.textColor = UIColorFromRGB(0x28282a);
    targetNameLabel.font = FONT_PT_FROM_PX(20);
    [self.tableHeaderView addSubview:targetNameLabel];
    self.targetNameLabel = targetNameLabel;
    [self.targetNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableHeaderView).offset(25);
        make.left.equalTo(self.tableHeaderView).offset(20);
    }];


    UITextField *targetNameTextField = [UITextField new];
//    targetNameTextField.keyboardType = UIKeyboardTypeNumberPad;
    targetNameTextField.placeholder = @"输入你的目标计划";
    [targetNameTextField setFont:FONT_PT_FROM_PX(26)];
    [targetNameTextField setTextColor:UIColorFromRGB(0x969797)];
    targetNameTextField.textAlignment = NSTextAlignmentCenter;
    targetNameTextField.text = self.editTargetModel.targetName;
    [self.tableHeaderView addSubview:targetNameTextField];
    self.targetNameTextField = targetNameTextField;
    [self.targetNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.tableHeaderView);
        make.top.equalTo(self.targetNameLabel.bottom).offset(30);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIColorFromRGB(0xe7dfc5);
    [self.tableHeaderView addSubview:line];
    self.line = line;
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(1);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(self.targetNameTextField.bottom).offset(5);
    }];

    
    
    BasicTableView *tableView = [BasicTableView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = MotifColor;
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    tableView.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
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

// 取消
- (void)leftClick:(id)sender {
    
    
   if (self.targetModel.phaseTableName) {


        // 删除phaae
        TargetManage *TM = [TargetManage sharedTargetManage];
       if (![TM deletePhaseTableWithPhaseName:self.targetModel.phaseTableName])
       {
           DEBUG_LOG(@"删除失败"); return;
           
       }else  {
           
            DEBUG_LOG(@"删除成功");
       }
       


   }
    
     [self.navigationController popViewControllerAnimated:YES];
}

// 确定
- (void)rigthClick:(id)sender {
    
    
    
    if (self.editTargetModel) {
       
        [self showSaving];
        //    [self showWaiting];
        TargetManage *targetManage = [TargetManage sharedTargetManage];
        //    if (![targetManage createDataBaseWithPath:nil])                                     { return; }
//        if (![targetManage addTargetWithTargetModel:[self getTargetModelofCurrentlyController]])  { return; }
        if(![targetManage updateTargetWithPrimaryKey:self.editTargetModel.ID Option:@{@"targetName":[self getTargetModelofCurrentlyController].targetName}]) {return ;}
//            [self showSuccess:@"新建成功"];
        
        [NSTimer scheduledTimerWithTimeInterval:1.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            [self hideHUD];
            [self showMessage:@"保存成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }];
        
        
    }else {
        
      
        
        [self showSaving];
        //    [self showWaiting];
        TargetManage *targetManage = [TargetManage sharedTargetManage];
        //    if (![targetManage createDataBaseWithPath:nil])                                     { return; }
        if (![targetManage addTargetWithTargetModel:[self getTargetModelofCurrentlyController]])  { return; }
        
        //    [self showSuccess:@"新建成功"];
        
        [NSTimer scheduledTimerWithTimeInterval:1.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            [self hideHUD];
            [self showMessage:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        
        
    }
    
   

    
   
    
}



- (TargetModel *)getTargetModelofCurrentlyController {
    
    DATE_FORMATTER(df)
   
    self.targetModel.targetName = self.targetNameTextField.text;
    self.targetModel.beginDate = [df dateFromString:self.startSelectBar.content];
    self.targetModel.endDate = [df dateFromString:self.endSelectBar.content];
    self.targetModel.awokeDate= [df dateFromString:self.awokeSelectBar.content];
    self.targetModel.phaseTableName = self.targetModel.phaseTableName ? self.targetModel.phaseTableName:@"";
    self.targetModel.awoke = NO;
    return self.targetModel;
    
}



- (void)addSelectBar {
   
    DATE_FORMATTER(df)
    Weak_Self(weakSelf);
    self.startSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"起始日期" ImagName:nil Action:^{
        
        NSLog(@"起始日期");
        self.tapPhaseBarStyle = TapPhaseBarStyleStartSelectBar;
        [weakSelf showDatePicker];
        
    }];
    self.startSelectBar.content = [df stringFromDate:self.editTargetModel.beginDate];
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
    self.endSelectBar.content = [df stringFromDate:self.editTargetModel.endDate];
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
    self.awokeSelectBar.content = [df stringFromDate:self.editTargetModel.awokeDate];
    [self.view addSubview:self.awokeSelectBar];
    [self.awokeSelectBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.endSelectBar.bottom).offset(10);
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.height.equalTo(SELECTBAR_HEIGHE);
    }];
    
    
    



    self.phaseSelectBar = [[HomeFoundTargetSelectBar alloc]initWithTitle:@"阶段" ImagName:@"" Action:^{

        if (!self.targetModel.phaseTableName) {
            
            self.targetModel.phaseTableName =  [NSString stringWithFormat:@"t_phase_%@",[NSString jk_UUIDTimestamp]];
        }
   
            HomeAddPhaseViewController *addPhaseVC = [[HomeAddPhaseViewController alloc]initWithPhaseName:self.targetModel.phaseTableName];
            addPhaseVC.delegate = self;
        BasicNavigationController *NaV = [[BasicNavigationController alloc]initWithRootViewController:addPhaseVC];
        [weakSelf presentViewController:NaV animated:YES completion:nil];
        
        
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
    TargetPhaseModel *model = self.phaseAry[indexPath.row];
    cell.targetPhaseModel = model;
    cell.title = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *phaseName = self.editTargetModel ? self.editTargetModel.phaseTableName:self.targetModel.phaseTableName;
    
    HomeAddPhaseViewController *VC = [[HomeAddPhaseViewController alloc]initWithPhaseModel:self.phaseAry[indexPath.row] PhaseName:phaseName];
    BasicNavigationController *nav = [[BasicNavigationController alloc]initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark --------------------------  增加阶段的控制器代理方法  ----------------------------------------
- (void)homeAddPhase:(HomeAddPhaseViewController *)homeAddPhase didAddInPhase:(NSString *)phase {
    
    // 更新
    DEBUG_LOG(@"%@",phase);

    self.targetModel.phaseTableName = phase;
//    TargetManage *TM= [TargetManage sharedTargetManage];

//    BOOL result =[TM updateTargetWithPrimaryKey:3 Option:@{@"PhaseName":phase}];
//    if (!result) { DEBUG_LOG(@"更新失败");return ; }
//    DEBUG_LOG(@"更新成功");
    
    
    
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


- (TargetModel *)targetModel {
    
    if (!_targetModel) {
        
        _targetModel = [TargetModel new];
    }
    
    return _targetModel;
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
