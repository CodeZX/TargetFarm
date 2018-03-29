//
//  TargetManage.m
//  TargetFarm
//
//  Created by apple on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "TargetManage.h"

#define DATE_FORMATTER(df)  NSDateFormatter *df  =   [NSDateFormatter new]; \
df.timeZone = [NSTimeZone systemTimeZone];\
df.dateFormat = @"YYYY-MM-dd HH:mm:ss";


//#define CREAT_TABLE_IFNOT_EXISTS             @"create table if not exists %@ (key text primary key, data blob)"
//#define DELETE_DATA_WITH_PRIMARYKEY          @"delete from %@ where key = ?"
//#define INSERT_TO_TABLE                      @"insert into %@ (key, data) values (?, ?)"
//#define READ_DATA_TABLE_WITH_PRIMARYKEY      @"select data from %@ where key = ?"
//#define READ_ALL_DATA                        @"select data from %@"
//#define UPDATE_DATA_WHTH_PRIMARYKEY          @"update %@ set data = ? where key = ?"
//#define CLEAR_ALL_DATA                       @"DELETE FROM %@"


// create
#define CREATE_TARGET_TABLE_IF_NOT_EXISTS @"CREATE TABLE IF NOT EXISTS t_target (id integer PRIMARY KEY AUTOINCREMENT, targetName text NOT NULL, beginDate datetime NOT NULL,endDate datetime NOT NULL,awokeDate datetime NOT NULL,phaseName text NOT NULL);"
#define CREATE_PHASE_TABLE_IF_NOT_EXISTS @"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, title text NOT NULL, content text NOT NULL,beginDate datetime NOT NULL,endDate datetime NOT NULL,awokeDate datetime NOT NULL,accomplish int NOT NULL);"


// add
#define INSERT_INTO_TABLE_TARGET @"INSERT INTO t_target (targetName,beginDate,endDate,awokeDate,phaseName) VALUES (?,?,?,?,?);"
#define INSERT_INTO_TABLE_PHASE  @"INSERT INTO %@ (title,content,beginDate,endDate,awokeDate,accomplish) VALUES (?,?,?,?,?,?);"


// delete


// update
#define UPDATE_TARGET @"update t_target set %@ = ? where id = ?;"
#define UPDATE_PHASE  @"update %@ set %@ = ? where id = ?;"

// select

@interface TargetManage ()


@end
@implementation TargetManage

static FMDatabase *db;
WMSingletonM(TargetManage)

- (BOOL)createDataBaseWithPath:(NSString *)path {
    
    if (!path || [path isEqualToString:@""]) {
        
        DEBUG_LOG(@"路径无效,使用默认路径");
        NSString* docsdir = PATH_OF_DOCUMENT;
        path = [docsdir stringByAppendingPathComponent:@"target.sqlite"];
       
    }
    
    db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        
        DEBUG_LOG(@"数据库创建失败");
        return NO;
    
    }else {
        
         DEBUG_LOG(@"数据库创建成功");
         DEBUG_LOG(@"%@",path);
    }
    
    return YES;
}

- (BOOL)createTargetTable {
    
    BOOL result = [db executeUpdate:CREATE_TARGET_TABLE_IF_NOT_EXISTS];
    if (!result) { DEBUG_LOG(@"创建表失败");return NO;}
    
    DEBUG_LOG(@"创建表成功");
    return YES;
}


- (NSString *)createPhaseTable {
    
    DATE_FORMATTER(df)
    NSString *tableName =  [NSString stringWithFormat:@"t_phase_%@",[NSString jk_UUIDTimestamp]];
    NSString *sql = [NSString stringWithFormat:CREATE_PHASE_TABLE_IF_NOT_EXISTS,tableName];
    BOOL result = [db executeUpdate:sql];
    if (!result) { DEBUG_LOG(@"创建表失败"); return @"";}
    DEBUG_LOG(@"创建表成功");
    return tableName;
}


- (BOOL)addTargetWithTargetModel:(TargetModel *)targetModel {
    
    [self createTargetTable];
    
   BOOL result =  [db executeUpdate:INSERT_INTO_TABLE_TARGET,targetModel.targetName,targetModel.beginDate,targetModel.endDate,targetModel.awokeDate,targetModel.phaseTableName];
    
    if (!result) {
        
        DEBUG_LOG(@"插入失败");
    
    }else {
        
        DEBUG_LOG(@"插入成功");
    }
    return YES;
}

- (BOOL)addPhaseWithPhase:(TargetPhaseModel *)phase PhaseName:(NSString *)phaseName {

    NSString *sql = [NSString stringWithFormat:INSERT_INTO_TABLE_PHASE,phaseName];
    BOOL result = [db executeUpdate:sql,phase.title,phase.content,phase.beginDate,phase.endDate,phase.awokeDate,@(phase.accomplish)];
    if (!result) { DEBUG_LOG(@"插入失败");return NO; }
    
    DEBUG_LOG(@"插入成功");
    return YES;
   
}

- (TargetModel *)getTarget {
    
    //查询整个表
    FMResultSet * resultSet = [db executeQuery:@"select * from t_target"];
    //根据条件查询
    //FMResultSet * resultSet = [_db executeQuery:@"select * from t_student where id < ?", @(4)];
    //遍历结果集合
    TargetModel *model = [TargetModel new];
    while ([resultSet next]) {
        model.ID = [resultSet intForColumn:@"id"];
        model.targetName = [resultSet stringForColumn:@"targetName"];
        model.phaseTableName = [resultSet stringForColumn:@"phaseName"];
        model.beginDate = [resultSet dateForColumn:@"beginDate"];
        model.endDate = [resultSet dateForColumn:@"endDate"];
        NSLog(@"id：%@ 目标：%@ 阶段：%@ 开始时间：%@ 结束时间：%@",@( model.ID),model.targetName,model.phaseTableName,model.beginDate,model.endDate);
        
    }

    
    return  model;
}


- (NSMutableArray *)allTarget {
    
    //查询整个表
    FMResultSet * resultSet = [db executeQuery:@"select * from t_target"];
    NSMutableArray *mutableAry = [NSMutableArray new];
    
    while ([resultSet next]) {
        
        TargetModel *model = [TargetModel new];
        model.ID = [resultSet intForColumn:@"id"];
        model.targetName = [resultSet stringForColumn:@"targetName"];
        model.phaseTableName = [resultSet stringForColumn:@"phaseName"];
        model.beginDate = [resultSet dateForColumn:@"beginDate"];
        model.endDate = [resultSet dateForColumn:@"endDate"];
        model.awokeDate = [resultSet dateForColumn:@"awokeDate"];
//        NSLog(@"id：%@ 目标：%@ 阶段：%@ 开始时间：%@ 结束时间：%@",@( model.ID),model.targetName,model.phaseTableName,model.beginDate,model.endDate);
        [mutableAry addObject:model];
    }
    
    
    return mutableAry;
    
}

- (NSMutableArray *)allPhaseFromPhaseName:(NSString *)phaseName {
    
    
    //查询整个表
    NSString *sql = [NSString stringWithFormat:@"select * from %@",phaseName];
    FMResultSet * resultSet = [db executeQuery:sql];
    NSMutableArray *mutableAry = [NSMutableArray new];
    
    while ([resultSet next]) {
        
        TargetPhaseModel *model = [TargetPhaseModel new];
        model.id = [resultSet intForColumn:@"id"];
        model.title = [resultSet stringForColumn:@"title"];
        model.content = [resultSet stringForColumn:@"content"];
        model.beginDate = [resultSet dateForColumn:@"beginDate"];
        model.endDate = [resultSet dateForColumn:@"endDate"];
        model.awokeDate = [resultSet dateForColumn:@"awokeDate"];
        model.accomplish = [resultSet boolForColumn:@"accomplish"];
        //        NSLog(@"id：%@ 目标：%@ 阶段：%@ 开始时间：%@ 结束时间：%@",@( model.ID),model.targetName,model.phaseTableName,model.beginDate,model.endDate);
        [mutableAry addObject:model];
    }
    
    
    return mutableAry;
}



- (BOOL)updateTargetWithPrimaryKey:(int)primaryKey Option:(NSDictionary *)option {
    
    NSString *key = [option allKeys].lastObject;
    NSString *sql = [NSString stringWithFormat:UPDATE_TARGET,key];
                     BOOL result = [db executeUpdate:sql,[option valueForKey:key],@(primaryKey)];
                     if (!result) { DEBUG_LOG(@"更新失败"); return NO;}
                     
                     DEBUG_LOG(@"更新失败");
                     return YES;
}


- (BOOL)upDatePhaseWithPhaseName:(NSString *)phaseName  PrimaryKey:(int)primaryKey Option:(NSDictionary *)option {
    
    NSString *key = [option allKeys].lastObject;
    NSString *sql = [NSString stringWithFormat:UPDATE_PHASE,phaseName,key];
    BOOL result = [db executeUpdate:sql,[option valueForKey:key],@(primaryKey)];
    if (!result) { DEBUG_LOG(@"更新失败"); return NO;}
    
    DEBUG_LOG(@"更新失败");
    return YES;
    
    
}


- (void)open {
    
    [self createDataBaseWithPath:nil];
}

- (void)close {
    
    if ([db close]) { DEBUG_LOG(@"数据库关闭！");return;}
        
    DEBUG_LOG(@"数据库关闭失败！");
    
}


@end
