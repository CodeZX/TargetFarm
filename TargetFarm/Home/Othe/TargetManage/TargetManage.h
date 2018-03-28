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
  add target

 @return <#return value description#>
 */
//- (BOOL)createTarget;

- (BOOL)addTargetWithTargetModel:(TargetModel *)targetModel;
/**
 delete target

 @return <#return value description#>
 */
- (BOOL)deleteTarget;

/**
 get target

 @return <#return value description#>
 */
- (TargetModel *)getTarget;


/**
 all target

 @return <#return value description#>
 */
-(NSMutableArray *)allTarget;
/**
 add  phase

 @return <#return value description#>
 */
- (BOOL)addPhaseWithPhase:(TargetPhaseModel *)phase TargetID:(NSInteger)id;


/**
  delete phase

 @param phase <#phase description#>
 @return <#return value description#>
 */
- (BOOL)deletePhaseWithPhase:(TargetScheduleModel *)phase;



/**
 get phase
 
 
 @return <#return value description#>
 */
- (TargetScheduleModel *)deletePhaseWithPhase;
@end
