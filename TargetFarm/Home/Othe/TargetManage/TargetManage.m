//
//  TargetManage.m
//  TargetFarm
//
//  Created by apple on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import "TargetManage.h"

#define CREAT_TABLE_IFNOT_EXISTS             @"create table if not exists %@ (key text primary key, data blob)"
#define DELETE_DATA_WITH_PRIMARYKEY          @"delete from %@ where key = ?"
#define INSERT_TO_TABLE                      @"insert into %@ (key, data) values (?, ?)"
#define READ_DATA_TABLE_WITH_PRIMARYKEY      @"select data from %@ where key = ?"
#define READ_ALL_DATA                        @"select data from %@"
#define UPDATE_DATA_WHTH_PRIMARYKEY          @"update %@ set data = ? where key = ?"
#define CLEAR_ALL_DATA                       @"DELETE FROM %@"


#define CREATE_TARGET_TABLE_IF_NOT_EXISTS @"CREATE TABLE IF NOT EXISTS t_target (id integer PRIMARY KEY AUTOINCREMENT, targetName text NOT NULL, beginDate datetime NOT NULL,endDate datetime NOT NULL, phaseName text NOT NULL);"
#define CREATE_PHASE_TABLE_IF_NOT_EXISTS @"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT, title text NOT NULL, content text NOT NULL,beginDate datetime NOT NULL,endDate datetime NOT NULL, accomplish BOOL NOT NULL);"
#define INSERT_TO_TABLE_TARGET @"INSERT INTO t_target (targetName,beginDate,endDate, phaseName) VALUES (?,?,?,?);"
#define INSERT_TO_TABLE_PHASE
@interface TargetManage ()


@end
@implementation TargetManage

static FMDatabase *db;
WMSingletonM(TargetManage)

- (BOOL)createDataBaseWithPath:(NSString *)path {
    
    if (!path) {
        
        DEBUG_LOG(@"路径无效,使用默认路径");
        NSString* docsdir = PATH_OF_DOCUMENT;
        path = [docsdir stringByAppendingPathComponent:@"target.sqlite"];
       
    }else {
        
//        NSString* docsdir = PATH_OF_DOCUMENT;
//        path = [docsdir stringByAppendingPathComponent:@"target.sqlite"];
        
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

- (BOOL)createTarget {
    
    BOOL result = [db executeUpdate:CREATE_TARGET_TABLE_IF_NOT_EXISTS];
    if (!result) {
        DEBUG_LOG(@"创建表失败");
    } else {
        DEBUG_LOG(@"创建表成功");
    }
    
   
    
    
    return YES;
}


- (BOOL)addTargetWithTargetModel:(TargetModel *)targetModel {
    
    [self createTarget];
    
   BOOL result =  [db executeUpdate:INSERT_TO_TABLE_TARGET,targetModel.targetName,targetModel.beginDate,targetModel.endDate,targetModel.phaseTableName];
    
    if (!result) {
        
        DEBUG_LOG(@"插入失败");
    
    }else {
        
        DEBUG_LOG(@"插入成功");
    }
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

- (BOOL)addPhaseWithPhase:(TargetPhaseModel *)phase TargetID:(NSInteger)id {
    
    
    NSString *phaseName = [NSString stringWithFormat:@"t_phase_100%ld",id];
    
    NSString *sqlStr = [NSString stringWithFormat:CREATE_PHASE_TABLE_IF_NOT_EXISTS,phaseName];
    BOOL result = [db executeUpdate:sqlStr];
    if (!result) {
        DEBUG_LOG(@"创建表失败");
    } else {
        
        DEBUG_LOG(@"创建表成功");
        
        BOOL result =  [db executeUpdate:@"INSERT INTO t_target (title,content,beginDate, endDate,accomplish) VALUES (?,?,?,?);",phase.title,phase.content,phase.beginDate,phase.endDate,phase.accomplish];
        
            if (!result) {
        
                DEBUG_LOG(@"插入失败");
        
            }else {
        
                DEBUG_LOG(@"插入成功");
            }
    }
    
    return YES;
}




//- (BOOL)insertPhase:(TargetPhaseModel *)phase {
//
//    BOOL result =  [db executeUpdate:@"INSERT INTO t_target (targetName,beginDate,endDate, phaseName) VALUES (?,?,?,?);",targetModel.targetName,targetModel.beginDate,targetModel.endDate,targetModel.phaseTableName];
//
//    if (!result) {
//
//        DEBUG_LOG(@"插入失败");
//
//    }else {
//
//        DEBUG_LOG(@"插入成功");
//    }
//
//    return YES;
//}

@end
