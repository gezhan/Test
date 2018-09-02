//
//  PositionModel.h
//  WinShare
//
//  Created by GZH on 2017/5/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiduHeader.h"

@interface PositionModel : NSObject

@property(nonatomic,copy)NSString *name;

//地址
@property(nonatomic,copy)NSString *address;

//经纬度
@property (nonatomic, assign) CLLocationCoordinate2D coor;

@end
