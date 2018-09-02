//
//  WSFTimePointPickerView.h
//  WinShare
//
//  Created by GZH on 2018/2/26.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFTimePointVM;

/**
 选中时间点的回调
 
 @param whenSring     选中的时
 @param pointsString  选中的分
 */
typedef void(^WhenPiontsBlock)(NSString *whenSring, NSString *pointsString);

@interface WSFTimePointPickerView : UIView


/**
 选中时间点的回调
*/
@property (nonatomic, copy) WhenPiontsBlock whenPiontsBlock;

/**
 初始化view
 @param timePointVM 数据
 */
- (instancetype)initWithTimePointVM:(WSFTimePointVM *)timePointVM;

@end
