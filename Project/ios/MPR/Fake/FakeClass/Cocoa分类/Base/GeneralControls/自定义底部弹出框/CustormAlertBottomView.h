//
//  CustormAlertBottomView.h
//  WinShare
//
//  Created by GZH on 2017/5/13.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(NSInteger);


@interface CustormAlertBottomView : UIViewController

@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,copy) ClickBlock clickBlock;

@end
