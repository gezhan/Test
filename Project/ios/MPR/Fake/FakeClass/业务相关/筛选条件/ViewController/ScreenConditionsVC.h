//
//  ScreenConditionsVC.h
//  WinShare
//
//  Created by GZH on 2017/5/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"
#import "BaiduHeader.h"

typedef NS_ENUM(NSInteger, WSFScreenConditionsType) {
    WSFScreenConditionsType_Normal,        // 默认，未做筛选
    WSFScreenConditionsType_InTheScreen    // 筛选中
};

typedef struct _WSFScreenNumberOfPeople {
    int minNumber;      // 最小人数
    int maxNumber;      // 最大人数
} WSFScreenNumberOfPeople;

// -------------- 不要 --------------
//coor->经纬度  str->地点  array1-> 预定时间   Array2->预定人数
typedef void(^ConditionsBlock)(CLLocationCoordinate2D coor, NSString *str, NSArray *array1, NSArray *array2);
// -------------- 不要 --------------

typedef void(^CompleteScreeningBlock)();
typedef void(^ResetScreeningBlock)();
typedef void(^ResetPlacemark)(CLPlacemark *placemark);

@interface ScreenConditionsVC : WSFBaseViewController

// -------------- 不要 --------------
@property (nonatomic, assign) double currentLongitude DEPRECATED_ATTRIBUTE; //当前选择的纬度
@property (nonatomic, assign) double currentLatitude DEPRECATED_ATTRIBUTE; //当前选择的经度
@property (nonatomic, copy) ConditionsBlock conditionsBlock DEPRECATED_ATTRIBUTE;
/** 所选人数区间-最少 */
@property (nonatomic, readonly, copy) NSNumber *currentMinPeople DEPRECATED_ATTRIBUTE;
/** 所选人数区间-最多 */
@property (nonatomic, readonly, copy) NSNumber *currentMaxPeople DEPRECATED_ATTRIBUTE;
// -------------- 不要 --------------

/** 当前位置 */
@property (nonatomic, readonly, copy) NSString *locationStr;
/** 筛选状态 */
@property (nonatomic, readonly, assign) WSFScreenConditionsType screenConditionsType;
/** 经纬度 */
@property (nonatomic, assign) CLLocationCoordinate2D coor;
/** 选定时间 */
@property (nonatomic, readonly, copy) NSString *currentTime;
/** 持续时长 */
@property (nonatomic, readonly, copy) NSNumber *currentDuration;
/** 筛选人数 */
@property (nonatomic, readonly, assign) WSFScreenNumberOfPeople screenNumberOfPeople;
/** 完成筛选掉回调 */
@property (nonatomic, copy) CompleteScreeningBlock completeScreeningBlock;
/** 完成筛选掉回调 */
@property (nonatomic, copy) ResetScreeningBlock resetScreeningBlock;
/** 重置筛选，将当前地点的信息回调 */
@property (nonatomic, copy) ResetPlacemark resetPlacemark;
/** 是否在筛选中 */
@property (nonatomic, getter=isInScreen, assign) BOOL inScreen;

/** 单例 */
+ (instancetype)shareManager;

/** 重置操作 */
- (void)resetControllersAction;

@end
