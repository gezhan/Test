//
//  EquipInformation.h
//  zcmjr
//
//  Created by nil on 2017/8/5.
//  Copyright © 2017年 Facebook. All rights reserved.
//
typedef void (^LBClick) (id);
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EquipInformation : UIViewController
@property (nonatomic, copy)LBClick callb;
-(NSMutableDictionary *)setDeviceIformation;
-(void)inits;
@end
