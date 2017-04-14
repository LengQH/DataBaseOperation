//
//  WorkType.m
//  haoworker
//
//  Created by ma c on 15/11/10.
//  Copyright © 2015年 gdd. All rights reserved.
//

#import "WorkType.h"

@implementation WorkType
//构造方法
-(id)initWithWorkTypeMess:(NSString *)wtid wtname:(NSString *)wtname parentid:(NSString *)parentid sort:(NSString *)sort{
    if (self=[super init]) {
        self.wtid=wtid;
        self.wtname=wtname;
        self.parentid=parentid;
        self.sort=sort;
    }
    return self;
}
//类方法
+(id)workTypeMess:(NSString *)wtid wtname:(NSString *)wtname parentid:(NSString *)parentid sort:(NSString *)sort{
    WorkType *workType=[[WorkType alloc]init];
    workType.wtid=wtid;
    workType.wtname=wtname;
    workType.parentid=parentid;
    workType.sort=sort;
    return workType;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.wtid forKey:@"wtid"];
    [aCoder encodeObject:self.wtname forKey:@"wtname"];
    [aCoder encodeObject:self.parentid forKey:@"parentid"];
    [aCoder encodeObject:self.sort forKey:@"sort"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.wtid =[aDecoder decodeObjectForKey:@"wtid"];
        self.wtname=[aDecoder decodeObjectForKey:@"wtname"];
        self.parentid=[aDecoder decodeObjectForKey:@"parentid"];
        self.sort=[aDecoder decodeObjectForKey:@"sort"];
    }
    return self;
}
@end
