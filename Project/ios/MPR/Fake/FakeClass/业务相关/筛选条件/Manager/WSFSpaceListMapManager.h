//
//  WSFSpaceListMapManager.h
//  WinShare
//
//  Created by devRen on 2017/11/16.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

// 几个名词说明
//
// 筛选 & 非筛选 数据 (将列表与地图数据的数据划分为这两类)
// 筛选 包括：
// 1.默认状态（即刚进入软件时的状态&重置后的状态，且两种状态等价）
// 2.筛选中状态（即在筛选界面做完响应操作，且点击确定）
// 非筛选 ：地图拖动时获取到的数据，只是暂时下界面展示，不影响筛选结果

#import <Foundation/Foundation.h>
#import "ScreenConditionsVC.h"
#import "SpaceMessageModel.h"
#import "WSFScreenReminderView.h"
#import "WSFCityModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^successBlock)(NSArray *spaceListArray);
typedef void (^failedBlock)(NSError *error);
typedef void (^screenVCCompleteBlock)();
typedef void (^screenVCResetBlock)();
typedef void (^mapVCBackBlock)(NSArray<SpaceMessageModel *> *listArray);
typedef void (^cityVCBackBlock)(NSString *cityName);

@interface WSFSpaceListMapManager : NSObject

/** 筛选获取到的空间列表数据 */
@property (nonatomic, readonly, strong) NSArray<SpaceMessageModel *> *screeningSpaceListArray;
/**  地区数据的本地存储 */
@property (nonatomic, readonly, strong) NSArray<WSFCityArrayModel *> *regionArray;
/** 提示条 */
@property (nonatomic, readonly, strong) WSFScreenReminderView *reminderView;
/** 筛选经纬度 */
@property (nonatomic, readonly, assign) CLLocationCoordinate2D screenCoor;
/** 当前切换到的城市 */
@property (nonatomic, readonly, assign) NSString *selectedCityName;
/** 重置回调（⚠️ 包括 : 1.筛选控制器的重置; 2:筛选条的重置.） */
@property (nonatomic, copy) screenVCResetBlock resetBlock;
/** 筛选地点信息 */
@property (nonatomic, copy) NSString *screenAddressStr;
/** 是否在筛选中 */
@property (nonatomic, getter=isInScreen, assign) BOOL inScreen;
/** 单例 */
+ (instancetype)shareManager;

///---------------------------
/// @name 获取空间列表数据网络请求
///---------------------------

/**
 在列表界面获取筛选空间列表数据
 请在成功的回调中调用 saveScreeningSpaceListArray： 方法保存数据
 
 @param pageIndex 页码
 @param pageSize 每页数据
 @param success 成功
 @param failed 失败
 */
+ (void)getConditionsSpaceListDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(__nonnull successBlock)success failed:(__nonnull failedBlock)failed;

/**
 在地图界面获取筛选空间列表数据
 请在成功的回调中调用 saveScreeningSpaceListArray： 方法保存数据
 
 @param success 成功
 @param failed 失败
 */
+ (void)getConditionsSpaceListDataWithSuccess:(__nonnull successBlock)success failed:(__nullable failedBlock)failed;

/**
 获取非筛选空间列表数据
 ⚠️ 使用场景：滑动地图时获取周围空间数据
 
 @param lng 经度
 @param lat 纬度
 @param success 成功
 @param failed 失败
 */
+ (void)getMomentSpaceListDataWithLng:(double)lng lat:(double)lat success:(__nonnull successBlock)success failed:(__nullable failedBlock)failed;

/**
  获取当前定位城市信息
 */
- (void)getCurrentCityInformationWithBlock:(void(^)(CLPlacemark *placemark))informatBlock;

///------------------
/// @name 保存筛选数据
///------------------

/**
 在获取新的筛选数据后保存
 
 @param listArray 最新列表数据
 */
- (void)saveScreeningSpaceListArray:(nonnull NSArray<SpaceMessageModel *> *)listArray;

/**
 保存当前切换到的城市
 
 @param cityName  城市
 */
- (void)saveCurrentCityName:(NSString *)cityName;

/**
  保存当前的地区数据
 
 @param regionArray  城市的数据
 */
- (void)saveRegionData:(NSArray<WSFCityArrayModel *> *)regionArray;

/**
 * 重置城市
 */
- (void)resetScreenCityCondition;

///--------------
/// @name 界面跳转
///--------------

/**
 跳转到筛选控制器
 ⚠️ 列表界面与地图界面都要此方法跳转

 @param VC 从哪个控制器开始跳
 @param completeBlock 筛选的回调
 */
- (void)pushToScreenVCFormVC:(nonnull UIViewController *)VC completeBlock:(__nonnull screenVCCompleteBlock)completeBlock;

/**
 跳转到地图控制器

 @param VC 从哪个控制器开始跳
 @param mapVCBack 返回的回调 (仅在需要更新数据时调用)
 */
- (void)pushToMapVCFormVC:(nonnull UIViewController *)VC mapVCBack:(__nonnull mapVCBackBlock)mapVCBack;

/**
 跳转到城市选择控制器
 
 @param VC 从哪个控制器开始跳
 */
- (void)pushToCityVCFormVC:(nonnull UIViewController *)VC cityVCBack:(__nonnull cityVCBackBlock)cityVCBack;

@end
NS_ASSUME_NONNULL_END
