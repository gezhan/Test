//
//  PositionLocationVC.h
//  WinShare
//
//  Created by GZH on 2017/5/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"
#import "BaiduHeader.h"


typedef void(^PositionBlock)(NSString *, CLLocationCoordinate2D coor);

@interface PositionLocationVC : WSFBaseViewController

@property (nonatomic, strong) NSString *locationStr;

/**  回调选中的地点 */
@property (nonatomic, copy) PositionBlock positionBlock;

@end
