//
//  SearchVC.h
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//


#import <UIKit/UIKit.h>
/*
 *JS跟原生桥接用
 */
#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>
#import <React/RCTConvert.h>
#import <React/RCTBridge.h>
@interface SearchVC : UIViewController<RCTBridgeModule>

@property (weak, nonatomic) IBOutlet UITableView *rootTableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@end
