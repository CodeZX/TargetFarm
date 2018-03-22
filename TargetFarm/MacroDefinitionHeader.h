//
//  MacroDefinitionHeader.h
//  TargetFarm
//
//  Created by apple on 2018/3/21.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#ifndef MacroDefinitionHeader_h
#define MacroDefinitionHeader_h



#pragma mark -----系统版本-----
/** 如果是iOS7以及之后的版本*/
#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
///** iOS 7 */
//#define IOS7_OR_LATER NLSystemVersionGreaterOrEqualThan(7.0)
///** iOS8*/
//#define IOS8_OR_LATER NLSystemVersionGreaterOrEqualThan(8.0)

#pragma mark ------一些个常用的宽高等----
#pragma mark 屏幕宽高
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

/** 状态条高度*/
#define StatusBar_Height 20
/**导航条高度*/
#define NavBar_Height 44
/** tabBar高度*/
#define TabBar_Height 49
/** 导航条整体高度 */
#define NavgationBar_Height 64

//适配iPhone x 底栏高度
#define Tabbar_Height     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define VoiceSearchHeight 150

/** frame */
#define Frame(x, y, width, height) CGRectMake((x),(y),(width),(height))
/** Size*/
#define Size(width, height) CGSizeMake((width), (height))
#pragma mark ----- 常用的对象 --------
/** 通知中心*/
#define kNotificationCenter [NSNotificationCenter defaultCenter]
/** 当前应用程序的主窗口 */
#define kKeyWindow [UIApplication sharedApplication].keyWindow
/** 用户的 NSUserDefault 对象*/
#define kUserDefault [NSUserDefaults standardUserDefaults]
/** 应用程序的AppDelegate */
#define kAppDelegate  ((AppDelegate*)[UIApplication sharedApplication].delegate)

#pragma mark 常用的多线程的名字的宏
/** Global_queue 异步线程*/
#define kGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
/** Main_queue  主线程 */
#define kMainQueue dispatch_get_main_queue()

#pragma mark------颜色，字体等----------
#pragma mark 颜色
/** 透明度为 1 的 RGB */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
/** RGBA */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
/** 使用十六进制的颜色*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 随机色 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

/** 常用颜色*/
#define BlackColor [UIColor blackColor] //黑色
#define WhiteColor [UIColor whiteColor] //白色
#define ClearColor [UIColor clearColor] //无色
#define GlobalBg  RGBCOLOR(243,243,243)

/**主题颜色*/
#define MotifColor RGBCOLOR(106,206,208)


#define BackgroundColor RGBCOLOR(243,243,243)

#pragma mark---便捷颜色---color for test---用来 Debug 的颜色
#define OrangeColor    [UIColor orangeColor]   //橙色
#define PurpleColor    [UIColor purpleColor]   //紫色
#define RedColor       [UIColor redColor]
#define WhiteColor     [UIColor whiteColor]
#define GrayColor      [UIColor grayColor]
#define YellowColor    [UIColor yellowColor]
#define GreenColor     [UIColor greenColor]
#define MagentaColor   [UIColor magentaColor] //品红,洋红 /mə'dʒentə/
#define BlueColor      [UIColor blueColor]
#define BrownColor     [UIColor brownColor]
#define AppColor       [UIColor colorWithRed:(113)/255.0f green:(205)/255.0f blue:(207)/255.0f alpha:1]

// Cell的分割线的颜色
#define CellSeparatorLineColor UIColorFromRGB(0xe8ecf0)

#pragma mark------ 字体------
/** 字体的宏定义(pt)*/
#define font(size) [UIFont systemFontOfSize:(size)]
/** 粗体字的宏定义*/
#define boldFont(size)  [UIFont boldSystemFontOfSize:(size)]
/** 字体的宏定义(px)*/
#define fontPx(size) [UIFont systemFontOfSize:size/2 + 2]


#pragma mark--  ------特殊的宏------
/** 这个是第三方布局使用的 一个特殊宏*/ //https://github.com/SnapKit/Masonry
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS  // 只要添加了这个宏，equalTo就等价于mas_equalTo

/** 类方法 中用来获取当前类的 self 指针 */
#define ClassSelf [self class]
/** 弱引用 weakSelf */
#define Weak_Self(weakSelf)  __weak __typeof(&*self)weakSelf = self ;
/** 获取当前应用的版本号，这个是从项目的plist文件中获取*/
#define AppVersions [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define AppVersion @"1.0"

/** 手机型号*/
#define IponeType [CoderTool iphoneType]

/** system_version版本号*/
#define iponeIOS  [[UIDevice currentDevice] systemName]


/** token 登录返回的token*/
#define AppToken @""

//***********以下为调试和打包相关固定写法勿动******************
/*
 Debug : 调试（开发阶段），系统会自定义一个叫做DEBUG的宏
 Release : 发布（打包），系统会自动删掉叫做DEBUG的宏
 */
#ifdef DEBUG
//PS： 以后调试的打印统一使用
#define NSLog(...)  NSLog(__VA_ARGS__)

#else

#define NSLog(...)

#endif

#ifdef DEBUG
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(format,...)
#endif

//5.自定义高效率的 NSLog
#ifdef DEBUG
#define ZXLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define ZXLog(...)



#endif

/***********以上为调试和打包相关固定写法勿动*******************/


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)




#pragma mark -----时间格式-----
#define TimeYearMonth @"yyyy年M月份"
#define TimeFormat30Day @"yyyy-MM"
/** HH 是24进制  hh 是十二进制的*/
#define TimeFormat24 @"yyyy-MM-dd HH:mm"
/** 十二进制的小时*/
#define TimeFormat12 @"yyyy-MM-dd hh:mm"

#endif /* MacroDefinitionHeader_h */
