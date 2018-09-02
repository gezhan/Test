//
//  BaiduMapVC.h
//  WinShare
//
//  Created by GZH on 2017/5/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSFMapEnum.h"
@class SpaceMessageModel;

/**  返回上一个界面时候的回调 */
typedef void(^PopLastBlock)();

@interface BaiduMapVC : WSFBaseViewController

@property (nonatomic, copy) PopLastBlock popLastBlock;
@property (nonatomic, assign) WSFLocationType locationType;

@end
