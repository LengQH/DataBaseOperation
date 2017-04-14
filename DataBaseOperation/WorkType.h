//
//  WorkType.h
//  haoworker
//
//  Created by ma c on 15/11/10.
//  Copyright © 2015年 gdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkType : NSObject<NSCoding>
@property (nonatomic,copy)NSString *wtid;
@property (nonatomic,copy)NSString *wtname;   
/** 区域ID */
@property (nonatomic,copy)NSString *parentid;
@property (nonatomic,copy)NSString *sort;
//构造方法
-(id)initWithWorkTypeMess:(NSString *)wtid wtname:(NSString *)wtname parentid:(NSString *)parentid sort:(NSString *)sort;
//类方法
+(id)workTypeMess:(NSString *)wtid wtname:(NSString *)wtname parentid:(NSString *)parentid sort:(NSString *)sort;
@end
