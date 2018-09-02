//
//  EquipInformation.h
//  zcmjr
//
//  Created by nil on 2017/8/5.
//  Copyright © 2017年 Facebook. All rights reserved.
//

typedef void (^LBClickM) (id);

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface EquipInformation : UIViewController
@property (nonatomic, copy)LBClickM callb;
-(NSMutableDictionary *)setDeviceIformation;
-(void)inits;
@end
