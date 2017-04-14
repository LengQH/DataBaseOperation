//
//  CityMess.h
//  haoworker
//
//  Created by ma c on 15/11/9.
//  Copyright © 2015年 gdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityMess : NSObject<NSCoding>
@property (nonatomic,copy)NSString *sort;
@property (nonatomic,copy)NSString *regionname;
/** 区域ID */
@property (nonatomic,copy)NSString *regionid;
@property (nonatomic,copy)NSString *parentid;
//构造方法
-(id)initWithCityMess:(NSString *)strSort regionname:(NSString *)strRegionname regionid:(NSString *)strRegionid parentid:(NSString *)strParentid;
//类方法
+(id)cityMess:(NSString *)strSort regionname:(NSString *)strRegionname regionid:(NSString *)strRegionid parentid:(NSString *)strParentid;
@end
