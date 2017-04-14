//
//  SearchCity.h
//  TestView
//
//  Created by ma c on 16/2/25.
//  Copyright © 2016年 gdd. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DataBaseOperation : NSObject

/**
 *  打开数据库
 *
 *  @param dataBaseName 打开数据库的名字
 */
- (void)openDB:(NSString *)dataBaseName;

/**
 *  创建表
 *
 *  @param tableName 表名
 *  @param fieldName 字段名字
 */
-(void)createTable:(NSString *)tableName fieldName:(NSArray *)fieldName;

/**
 *  插入数据
 *
 *  @param tableName 表名
 *  @param fieldName 插入的字段名
 *  @param data      插入的数据
 */
-(void)insertData:(NSString *)tableName fieldName:(NSArray *)fieldName date:(NSArray *)arrData;
/**
 *  查询表中所有的数据
 *
 *  @param tableName 表名
 *  @param field     查询的字段
 *
 *  @return  结果数据
 */
-(NSArray *)selectAllData:(NSString *)tableName selectField:(NSArray *)field;
/**
 *  条件查询
 *
 *  @param strSQL 查询SQL语句
 *  @param field  查询的字段
 *
 *  @return 结果数据
 */
-(NSArray *)selectWithCondition:(NSString *)strSQL selectField:(NSArray *)field;
/**
 *  更新 修改表中的数据
 *
 *  @param tableName      表名
 *  @param setField       要设置的字段
 *  @param fieldValue     字段对应的值
 *  @param condition      条件
 *  @param conditionValue 条件值
 */
-(void)updateData:(NSString *)tableName setField:(NSArray *)setField fieldValue:(NSArray *)fieldValue condition:(NSArray *)condition conditionValue:(NSArray *)conditionValue;
/**
 *  删除表
 *
 *  @param tableName 表名
 */
-(void)deleteTable:(NSString *)tableName;
/**
 *  清空表中的数据
 *
 *  @param tableName 表名
 */
-(void)deleteTableAllData:(NSString *)tableName;
/**
 *  条件删除表中的数据
 *
 *  @param tableName      表名
 *  @param conditionArr   条件字段
 *  @param conditionValue 字段对应的值
 */
-(void)deleteTableDataWithCondition:(NSString *)tableName conditionArr:(NSArray *)conditionArr conditionValue:(NSArray *)conditionValue;
@end
