//
//  TheLoginVC.h
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WSFPopType) {
    WSFPopType_PopDefaultType           ,      //返回到上一层
    WSFPopType_PopRootType              ,      //返回到首页
    WSFPopType_PopLastTwoLayerType      ,      //返回到上两层
};


@interface TheLoginVC : WSFBaseViewController

@property (nonatomic, assign) WSFPopType loginType;

/**  出发点控制器（是从哪个控制器跳过来的） */
@property (nonatomic, strong) UIViewController *tempVC;

@end
