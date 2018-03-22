//
//  CommonTableViewTool.m
//  HKGoodColor
//
//  Created by chenkaijie on 2017/12/21.
//  Copyright © 2017年 chenkaijie. All rights reserved.
//

#import "CommonTableViewTool.h"
#import "CommonTableViewHeaderFooterView.h"
#import "CommonTableViewCell.h"
#import "CommonHeaderFooterModel.h"

@interface CommonTableViewTool () 

@property (strong, nonatomic) NSMutableDictionary *cell_Model_keyValues;
@property (strong, nonatomic) NSMutableDictionary *header_Model_keyValues;

/**
 *  命名空间，为了防止Swift中没法加载正确的类名
 */
@property (copy, nonatomic) NSString *namespace;

@property (strong, nonatomic) UIView *tempHeaderFooterView;

@end

@implementation CommonTableViewTool


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    CommonHeaderFooterModel *headerModel = self.dataArr[section].headerModel;
    
    NSString *modelClassName = [NSString stringWithUTF8String:object_getClassName(headerModel)];
    
    NSString *headerClass = self.header_Model_keyValues[modelClassName];
    
    if (headerClass) {
        
        CommonTableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerClass];
        
        if (headerView == nil) {
            headerView = [[NSClassFromString(headerClass) alloc] initWithReuseIdentifier:headerClass];
        }
        headerView.headerFooterModel = headerModel;
        
        return headerView;
    } else {
        
        return self.tempHeaderFooterView;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CommonHeaderFooterModel *headerModel = self.dataArr[section].headerModel;
    
    NSDictionary *keyValue = @{@"TJCycyleModel" : @"200", @"TJCollectionModel" : @"160"};
    NSString *modelClass = [NSString stringWithUTF8String:object_getClassName(headerModel)];
    NSString *height_string = keyValue[modelClass];
    
    if (height_string) {
        return height_string.floatValue;
    } else {
        return 0.01;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *array = self.dataArr;
    [self cell_Model_keyValues];
    return array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CommonSectionModel *sectionModel = self.dataArr[section];
    NSInteger count = sectionModel.modelArray.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;
#warning 如果是Xib/StoryBoard 显示不出来，可能是因为 CommonTableViewCellModel.isRegisterXib 没有设置为 YES
    
    
    CommonTableViewCellModel *model = self.dataArr[section].modelArray[row];
    
    NSString *modelName = [NSString stringWithUTF8String:object_getClassName(model)];
    modelName = [self return_ModelName:modelName];
    
    if ([modelName containsString:self.namespace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:self.namespace].length;
        modelName = [modelName substringFromIndex:from];
    }
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:modelName];
    if (cell == nil) {
        NSString *cellClass = self.cell_Model_keyValues[modelName];
        if (cellClass) {
            if (model.isRegisterXib) {
                cell = [tableView dequeueReusableCellWithIdentifier:cellClass forIndexPath:indexPath];
            } else {
                cell = [[[self returnCellClass_cellClassString:cellClass] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellClass];
            }
        } else {
            cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CommonTableViewCell class])];
        }
    }
    cell.cellModel = model;
    [cell setupData:model section:section row:row tableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section, row = indexPath.row;
    CommonSectionModel *sectionModel = self.dataArr[section];
    CommonTableViewCellModel *cellModel = sectionModel.modelArray[row];
    
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtSection:row:model:tableViewTool:)]) {
        [self.delegate tableView:tableView didSelectRowAtSection:section row:row model:cellModel tableViewTool:self];
    }
}

#pragma mark - 懒加载

- (NSString *)namespace {
    if (_namespace) return _namespace;
    NSString *namespace = [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
    namespace = [NSString stringWithFormat:@"%@.", namespace];
    _namespace = namespace;
    return _namespace;
}

#pragma mark - 键值对
- (NSMutableDictionary *)cell_Model_keyValues {
    if (_cell_Model_keyValues) return _cell_Model_keyValues;
    _cell_Model_keyValues = [NSMutableDictionary dictionary];
    NSDictionary *dic = @{@"CommonTableViewCellModel" : @"CommonTableViewCell",
                          @"KJCellModel" : @"KJCell",
                          
                          @"HomeCellModel" : @"HomeCell",
                          @"HomeSubCellModel" : @"HomeSubCell"
                          };
    [_cell_Model_keyValues addEntriesFromDictionary:dic];
    
   
    for (NSString *key in _cell_Model_keyValues.allKeys) {
        NSString *cellName = _cell_Model_keyValues[key];
        if (cellName == nil) {
            continue;
        }
        [self.tablView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
    }
    
    return _cell_Model_keyValues;
}
- (NSMutableDictionary *)header_Model_keyValues {
    if (_header_Model_keyValues) return _header_Model_keyValues;
    _header_Model_keyValues = [NSMutableDictionary dictionary];
    NSDictionary *dic = @{@"TJCycyleModel" : @"TJCycleView"
                          
                          };
    [_header_Model_keyValues addEntriesFromDictionary:dic];
    return _header_Model_keyValues;
}

- (UIView *)tempHeaderFooterView {
    if (_tempHeaderFooterView) return _tempHeaderFooterView;
    _tempHeaderFooterView = [UIView new];
    return _tempHeaderFooterView;
    
}

#pragma mark - Swift命名空间处理
- (NSString *)return_ModelName:(NSString *)modelName {
    if ([modelName containsString:self.namespace]) { // 为了Swift处理命名空间
        NSUInteger from = [modelName rangeOfString:self.namespace].length;
        modelName = [modelName substringFromIndex:from];
    }
    return modelName;
}
- (Class)returnCellClass_cellClassString:(NSString *)cellClassString {
    // 为了Swift处理命名空间
    Class ocClass = NSClassFromString(cellClassString);
    Class swiftClass = NSClassFromString([NSString stringWithFormat:@"%@%@", self.namespace, cellClassString]);
    return ocClass ? ocClass : swiftClass;
}



@end
