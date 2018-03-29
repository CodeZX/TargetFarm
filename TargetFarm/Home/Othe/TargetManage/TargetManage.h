//
//  TargetManage.h
//  TargetFarm
//
//  Created by apple on 2018/3/26.
//  Copyright © 2018年 chenkaijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetModel.h"
#import "TargetScheduleModel.h"
#import "TargetPhaseModel.h"

@interface TargetManage : NSObject

WMSingletonH(TargetManage)
// 初始化数据库
- (BOOL)createDataBaseWithPath:(NSString *)path;


/**
 初始化目标表

 @return <#return value description#>
 */
- (BOOL)createTargetTable;


/**
 添加目标

 @param targetModel 目标模型
 @return <#return value description#>
 */
- (BOOL)addTargetWithTargetModel:(TargetModel *)targetModel;


/**
 获取所有的目标

 @return <#return value description#>
 */
- (NSMutableArray *)allTarget;



/**
 更新目标

 @param option <#data description#>
 @param primaryKey <#key description#>
 @return <#return value description#>
 */
- (BOOL)updateTargetWithPrimaryKey:(int)primaryKey Option:(NSDictionary *)option;


/**
 delete target

 @return <#return value description#>
 */
//- (BOOL)deleteTarget;

/**
 get target

 @return <#return value description#>
 */
//- (TargetModel *)getTarget;



/**
 新建阶段表

 @return 阶段表名 —— 当前时间
 */
- (NSString *)createPhaseTable;

/**
 添加阶段到目标中

 @param phase <#phase description#>
 @param phaseName <#phaseName description#>
 @return <#return value description#>
 */
- (BOOL)addPhaseWithPhase:(TargetPhaseModel *)phase PhaseName:(NSString *)phaseName;

/**
 获取目标的所有阶段

 @param phaseName <#phaseName description#>
 @return <#return value description#>
 */
- (NSMutableArray *)allPhaseFromPhaseName:(NSString *)phaseName;



/**
 更新阶段

 @param phaseName <#phaseName description#>
 @param primaryKey <#data description#>
 @param option <#key description#>
 @return <#return value description#>
 */
- (BOOL)upDatePhaseWithPhaseName:(NSString *)phaseName  PrimaryKey:(int)primaryKey Option:(NSDictionary *)option;
/**
  delete phase

 @param phaseName <#phase description#>
 @return <#return value description#>
 */
- (BOOL)deletePhaseTableWithPhaseName:(NSString *)phaseName;



/**
 get phase
 
 
 @return <#return value description#>
 */
- (TargetScheduleModel *)deletePhaseWithPhase;
@end
