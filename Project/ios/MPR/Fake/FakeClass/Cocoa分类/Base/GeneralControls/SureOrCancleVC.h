//
//  SureOrCancleVC.h
//  WinShare
//
//  Created by GZH on 2017/5/8.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

/**  点击确定按钮 */
typedef void(^ClickSureBlock)(void);

@interface SureOrCancleVC : UIViewController


/**  提示语 */
@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, copy) ClickSureBlock clickSureBlock;

@end
