//
//  ViewController.m
//  TestView
//
//  Created by ma c on 16/2/24.
//  Copyright © 2016年 gdd. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseOperation.h"

@interface ViewController (){
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
#pragma mark 操作
- (IBAction)dbOperation:(UIButton *)sender {

    
    DataBaseOperation *dbOperation=[[DataBaseOperation alloc]init];
    
    [dbOperation openDB:@"ProvinceDB"]; // 打开数据库
    NSArray *resultArr=[dbOperation selectWithCondition:@"select rowid, * from Province where parentid=0 " selectField:@[@"",@"",@""]];
    NSLengLog(@"返回的值:%@, 长度是:%zi",resultArr,resultArr.count);

}
@end
