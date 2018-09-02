//
//  HKLPickerView.h
//  safeepay-ios-new
//
//  Created by san_xu on 2016/11/28.
//  Copyright © 2016年 com.app.huakala. All rights reserved.
//

#import <UIKit/UIKit.h>

//array1  展示需要的数据  array2后台需要的数据
typedef void(^ConfirmBtnClickBlock)(NSArray *array1, NSArray *array2);

@interface HKLPickerView : UIView

/**
 *  PickerView数据源
 */
@property (strong,nonatomic)NSArray * dataSource;


/**
 *  确定按钮回调
 */
@property (copy,nonatomic)ConfirmBtnClickBlock confirmBtnClickBlock;

@property (nonatomic, strong) NSArray *selectedArray; //选中的开始时间，和间隔时长

@property (nonatomic, strong) NSString *reSetStr; //选中的开始时间，和间隔时长

@end
