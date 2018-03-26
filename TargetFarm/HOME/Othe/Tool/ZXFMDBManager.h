//
//  ZXFMDBManager.h
//  TargetFarm
//
//  Created by apple on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void(^getDataByPrimaryKey)(NSData *data);
typedef void(^getAllData)(NSArray *dataArr);

@interface ZXFMDBManager : NSObject

+ (ZXFMDBManager *)sharedInstance;

//add the data by primaryKey in table
- (BOOL)addDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(NSData *)data;

//delete the data by primaryKey in table
- (BOOL)deleteDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey;

//update data by primaryKey in table
- (BOOL)updateDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(NSData *)data;

//read the data by primaryKey in table
- (BOOL)readDataWithTableName:(NSString *)tableName primaryKey:(NSString *)primaryKey data:(getDataByPrimaryKey)dataBlock;

//read all the data in table
- (BOOL)readAllDataWithTableName:(NSString *)tableName dataArr:(getAllData)allDataBlock;

//clear the dataBase
- (BOOL)clearDataBaseWithTableName:(NSString *)tableName;
@end
