//
//  SearchCity.m
//  TestView
//
//  Created by ma c on 16/2/25.
//  Copyright © 2016年 gdd. All rights reserved.
//

#import "DataBaseOperation.h"

#import <sqlite3.h>
@interface DataBaseOperation(){
    sqlite3 *dataBase;
}
/** 查询的字段 */
@end
@implementation DataBaseOperation

#pragma  mark 打开数据库
- (void)openDB:(NSString *)dataBaseName{
    
    NSArray *nameArr=[dataBaseName componentsSeparatedByString:@"."];
    NSString *dataName=[NSString stringWithFormat:@"%@.sqlite",nameArr[0]];
    
    NSLengLog(@"拼接的数据库的名字:%@",dataName);

    NSString *strPath=[[NSBundle mainBundle]pathForResource:dataName ofType:nil];//本地存放的路径
    if(strPath.length<1){ // 如果本地没有,就放在沙盒里面
        strPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:dataName]; // 拼接路径
    }
//    NSLengLog(@"存放路径是:%@",strPath);

    // 如果数据库不存在,新建并打开一个数据库，否则直接打开
    int result=sqlite3_open(strPath.UTF8String, &dataBase); // UTF8String是将 OC中的NSString转化成 C中的char
    if (result==SQLITE_OK) {
        NSLengLog(@"打开数据库《%@》成功!",dataBaseName);
    }
    else{
        NSLengLog(@"打开数据库《%@》失败!",dataBaseName);
    }
}
#pragma  mark 创建表
-(void)createTable:(NSString *)tableName fieldName:(NSArray *)fieldName{
    
    NSString *linkStr=@"";
    for (int i=0; i<fieldName.count; i++) {
        NSString *strField=fieldName[i];
        NSString *strSec=[strField stringByAppendingString:@" TEXT,"];
        linkStr=[linkStr stringByAppendingString:strSec];
    }
    NSString *linkSecStr=[linkStr substringToIndex:linkStr.length-1]; //去除最后一个,
    NSString *addStr=[NSString stringWithFormat:@" (%@)",linkSecStr];
    
    NSString *strTable=[NSString stringWithFormat:@"create table if not exists %@",tableName];
    NSString *strFinaSQL=[strTable stringByAppendingString:addStr]; //最终拼接的SQL语句
    
    // 写死了的正确的SQL语句
// NSString *strSQL=@"CREATE TABLE IF NOT EXISTS Province (sort TEXT, regionname TEXT, regionid TEXT, parentid TEXT)";//创建表(Province)里面有4个字段
    
    [self exeSQL:strFinaSQL];
}

#pragma mark 插入数据
-(void)insertData:(NSString *)tableName fieldName:(NSArray *)fieldName date:(NSArray *)arrData{
    if ((arrData.count>0&&fieldName.count>0)&&fieldName.count<=arrData.count) {
        
        NSString *strStart=@"";  // 用来拼接字段的
        NSString *strValue=@""; // 用来拼接值的
        for (int i=0; i<fieldName.count; i++) {
            NSString *value=[fieldName[i] stringByAppendingString:@", "];
            strStart=[strStart stringByAppendingString:value]; //(拼接的字段名)
            
            strValue=[strValue stringByAppendingString:[NSString stringWithFormat:@"'%@', ",arrData[i]]];// 拼接的'值'
        }
        NSString *strLink=[strStart substringToIndex:strStart.length-2];      //去除最后的一个空格和,(拼接的字段名)
        NSString *strFinaValue=[strValue substringToIndex:strValue.length-2]; //去除最后的一个空格和,(拼接的'%@')
        
        NSString *strSecLink=[NSString  stringWithFormat:@"insert into %@ (%@) values (%@)",tableName,strLink,strFinaValue];
        NSLengLog(@"SQL语句:%@",strSecLink);
        
//    NSString *strSQL=@"INSERT INTO Province (sort, regionname, regionid, parentid) VALUES ('1', '2', '3', '4')"; // 写死了的插入数据SQL语句
        
        [self exeSQL:strSecLink];
    }
    else{
        NSLengLog(@"对应字段缺少对应的数据");
    }
}
#pragma mark 查询表中所有的数据
-(NSArray *)selectAllData:(NSString *)tableName selectField:(NSArray *)field{
    
    NSString *linkStr=[NSString stringWithFormat:@"select rowid, * from '%@'",tableName];
    return [self selectResult:linkStr selectField:field];
}
#pragma mark 条件查询表中的数据
-(NSArray *)selectWithCondition:(NSString *)strSQL selectField:(NSArray *)field{
    return [self selectResult:strSQL selectField:field];
}
#pragma  mark 查询数据
-(NSArray *)selectResult:(NSString *)SQLStr selectField:(NSArray *)field{
    
    NSMutableArray *arrFinaValue=[NSMutableArray array];
    sqlite3_stmt *stmt = NULL;
//    NSLengLog(@"查询返回代码:%zi",sqlite3_prepare_v2(dataBase, SQLStr.UTF8String, -1, &stmt, nil));
    
    if (sqlite3_prepare_v2(dataBase, SQLStr.UTF8String, -1, &stmt, nil) == SQLITE_OK) {
        NSMutableArray *addValue;
//        NSLengLog(@"stmt :%zi",sqlite3_step(stmt));
        while (sqlite3_step(stmt) ==SQLITE_ROW) {
            addValue=[NSMutableArray array];
            for (int i=0; i<field.count; i++) { // 各个字段对应的值
                char *regionid=(char*)sqlite3_column_text(stmt, i+1);
                NSString *finaSelectValue=[[NSString alloc]initWithUTF8String:regionid];
                [addValue addObject:finaSelectValue];
            }
            [arrFinaValue addObject:addValue];
            
            //            int _idOne =sqlite3_column_int(stmt,0); //得到d对应的ID
            //得到第一个字段的值
            //            char *sort = (char*)sqlite3_column_text(stmt,1);//得到第一个字段的值(char)
            //            NSString *strSort = [[NSString alloc]initWithUTF8String:sort];//将char转为NSString
            //            //同理得到第二个字段的值
            //            char *regionname=(char*)sqlite3_column_text(stmt, 2);
            //            NSString *strRegionname=[[NSString alloc]initWithUTF8String:regionname];
            //            //同理得到得到第三个字段的值
            //            char *regionid=(char*)sqlite3_column_text(stmt, 3);
            //            NSString *strRegionid=[[NSString alloc]initWithUTF8String:regionid];
            //            //同理得到得到第四个字段的值
            //            char *parentid=(char*)sqlite3_column_text(stmt, 4);
            //            NSString *strParentid=[[NSString alloc]initWithUTF8String:parentid];
            //            NSLengLog(@"工种第一个值:%@ 第二个值:%@ 第三个值:%@ 第四个值:%@ ",strSort,strRegionname,strRegionid,strParentid);
        }
    }
    else{
        NSLengLog(@"查询失败,可能SQL语句错误,可能表中没有对应的字段");
    }
    //     4. 释放句柄
    sqlite3_finalize(stmt);
    sqlite3_close(dataBase);//查询完就关闭数据库
    
    return arrFinaValue;
}
#pragma mark 跟新数据
-(void)updateData:(NSString *)tableName setField:(NSArray *)setField fieldValue:(NSArray *)fieldValue condition:(NSArray *)condition conditionValue:(NSArray *)conditionValue{
    

    
    if ((setField.count==fieldValue.count)&&(condition.count==conditionValue.count)) {
        NSString *strTableName=[NSString stringWithFormat:@"update %@ set ",tableName];
        
        NSString *strLink=@"";  // 先拼接的字段对应的值
        for (int i=0; i<setField.count; i++) {
            NSString *strField=setField[i];   // 字段
            NSString *strValue=fieldValue[i]; // 字段对应的值
            
            NSString *link=[strField stringByAppendingString:[NSString stringWithFormat:@"='%@',",strValue]];
            strLink=[strLink stringByAppendingString:link];
        }
        NSString *strSecLink=[strTableName stringByAppendingString:strLink];
        NSString *strSubLink=[strSecLink substringToIndex:strSecLink.length-1];
        
        NSString *strWhere=[self linkConditionAndValue:condition conditionValue:conditionValue];
        NSString *finaSQLStr=[strSubLink stringByAppendingString:strWhere];
        
        
        //    UPDATE upTable SET nowver = '5', nowdata = '10' WHERE cvid = '1'   // 单条件
        //    update workType set wtid = '200', wtname = '冷求慧'  where parentid='131' and sort='6' //多条件
        
        NSLengLog(@"更新数据拼接的SQL:%@",finaSQLStr);
        
        [self exeSQL:finaSQLStr];

    }
}
#pragma mark 删除表
-(void)deleteTable:(NSString *)tableName{
    NSString *strSQL=[NSString stringWithFormat:@"drop table %@ ",tableName];
    [self exeSQL:strSQL];
}
#pragma mark 清空表中的数据
-(void)deleteTableAllData:(NSString *)tableName{
    NSString *strSQL=[NSString stringWithFormat:@"delete from %@ ",tableName];
    [self exeSQL:strSQL];
}
#pragma mark 条件删除表中的数据
-(void)deleteTableDataWithCondition:(NSString *)tableName conditionArr:(NSArray *)conditionArr conditionValue:(NSArray *)conditionValue{
    
    //delete from workType where rowid='5' and  wtid='131' and wtname='内墙抹灰' parentid='114' sort='5'
    
    NSString *strWhere=[self linkConditionAndValue:conditionArr conditionValue:conditionValue]; // 得到Where后面的参数和值
    NSString *strFinaSQL=[[NSString stringWithFormat:@"delete from %@ ",tableName] stringByAppendingString:strWhere];
    
    NSLengLog(@"删除表最终的SQL语句:%@",strFinaSQL);
    
    [self exeSQL:strFinaSQL];
}

#pragma mark 拼接 where 条件和条件参数
-(NSString *)linkConditionAndValue:(NSArray *)conditionArr conditionValue:(NSArray *)conditionValue{
    
    if (conditionArr.count==conditionValue.count) {
        NSString *linkCondi=@"";
        for (int i=0; i<conditionValue.count; i++) {
            NSString *conditionStr=conditionArr[i];
            NSString *conValueStr=conditionValue[i];
            
            NSString *link=[conditionStr stringByAppendingString:[NSString stringWithFormat:@"='%@' and ",conValueStr]];
            linkCondi=[linkCondi stringByAppendingString:link];
        }
        NSString *subCondiLink=[linkCondi substringToIndex:linkCondi.length-5];
        NSString *strFinwWhereSQL=[NSString stringWithFormat:@"where %@",subCondiLink];
        return strFinwWhereSQL;
    }
    return @"";
}

#pragma mark 执行非SQL查询语句
-(void)exeSQL:(NSString *)strSQL{
    char *errorMess;
    int exeResult=sqlite3_exec(dataBase, strSQL.UTF8String, NULL, NULL, &errorMess); // strSQL.UTF8String NSString 转为char类型
    if (exeResult==SQLITE_OK) {
        NSLengLog(@"操作成功");
    }
    else{
        NSLengLog(@"操作失败,可能数据库未打开,亦或SQL语句错误!");
    }
}
// 调用
//NSString *className=[NSString stringWithUTF8String:object_getClassName(data)]; //得到类名(NSString)
//NSArray *backProperty=[self allPropertyNames:className]; // 通过类名去遍历类中的属性


#pragma  mark 遍历Model类中的属性
/**
 *  遍历Model类中的属性
 *
 *  @param className 类名
 *  @return 返回属性的名字
 */
- (NSArray *) allPropertyNames:(NSString *)className{
    
    NSMutableArray *allNames = [[NSMutableArray alloc] init]; //存储所有的属性名称
    unsigned int propertyCount = 0;//存储属性的个数
    objc_property_t *propertys = class_copyPropertyList([NSClassFromString(className) class], &propertyCount);//通过运行时获取当前类的属性(NSString 转为Class)
    for (int i = 0; i < propertyCount; i ++) { //把属性放到数组中
        objc_property_t property = propertys[i];//取出第一个属性
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertys); //释放
    return allNames;
}
@end
