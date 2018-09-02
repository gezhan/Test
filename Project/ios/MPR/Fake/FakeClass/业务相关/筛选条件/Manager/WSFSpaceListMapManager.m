//
//  WSFSpaceListMapManager.m
//  WinShare
//
//  Created by devRen on 2017/11/16.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSpaceListMapManager.h"
#import "SpaceDataVM.h"
#import "ScreenConditionsVC.h"
#import "BaiduMapVC.h"
#import "MapPositionManager.h"
#import "WSFCityChooseVC.h"

@interface WSFSpaceListMapManager()

@property (nonatomic, readwrite, strong) NSArray<SpaceMessageModel *> *screeningSpaceListArray;
@property (nonatomic, readwrite, strong) WSFScreenReminderView *reminderView;
@property (nonatomic, readwrite, assign) CLLocationCoordinate2D screenCoor;
/** 当前地点的信息 */
@property (nonatomic, strong) CLPlacemark *placemark;

@end

@implementation WSFSpaceListMapManager

+ (instancetype) shareManager {
    static WSFSpaceListMapManager *staticInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance = [[self alloc] init];
    }) ;
    return staticInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _screeningSpaceListArray = [[NSArray alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetButtonClick:) name:WSFScreenReminderViewResetButtonClickNotification object:nil];
        self.screenCoor = [ScreenConditionsVC shareManager].coor;
        self.screenAddressStr = @"";
        self.inScreen = [ScreenConditionsVC shareManager].isInScreen;
    }
    return self;
}

#pragma mark - 网络请求
+ (void)getConditionsSpaceListDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(successBlock)success failed:(failedBlock)failed {
    ScreenConditionsVC *screenVC = [ScreenConditionsVC shareManager];
//    if (screenVC.coor.latitude == 0.0) {
        [[MapPositionManager sharedLocationManager] getCoorinate:^(CLLocationCoordinate2D coordinate) {
            screenVC.coor = coordinate;
            [WSFSpaceListMapManager shareManager].screenCoor = coordinate;
            [SpaceDataVM getSpaceListDataWithLng:coordinate.longitude lat:coordinate.latitude selectTime:screenVC.currentTime duration:[screenVC.currentDuration integerValue] minPeople:screenVC.screenNumberOfPeople.minNumber maxPeople:screenVC.screenNumberOfPeople.maxNumber pageIndex:pageIndex pageSize:pageSize success:^(NSArray *spaceListArray) {
                if ([[WSFSpaceListMapManager shareManager].selectedCityName isEqualToString:@"杭州市"]) {
                    if (success) {
                        success(spaceListArray);
                    }
                }else {
                    NSMutableArray *tempArray = [NSMutableArray array];
                    if (success) {
                        success(tempArray);
                    }
                }
            } failed:^(NSError *error) {
                if (failed) {
                    failed(error);
                }
            }];
        } address:^(CLPlacemark *placemark) {
            [WSFSpaceListMapManager shareManager].placemark = placemark;
        } error:nil];
}

+ (void)getConditionsSpaceListDataWithSuccess:(successBlock)success failed:(failedBlock)failed {
    ScreenConditionsVC *screenVC = [ScreenConditionsVC shareManager];
    if (screenVC.coor.latitude == 0.0) {
        [[MapPositionManager sharedLocationManager] getCoorinate:^(CLLocationCoordinate2D coordinate) {
            screenVC.coor = coordinate;
            [SpaceDataVM getSpaceListDataWithLng:coordinate.longitude lat:coordinate.latitude selectTime:screenVC.currentTime duration:[screenVC.currentDuration integerValue] minPeople:screenVC.screenNumberOfPeople.minNumber maxPeople:screenVC.screenNumberOfPeople.maxNumber pageIndex:1 pageSize:1000 success:^(NSArray *spaceListArray) {
                if ([[WSFSpaceListMapManager shareManager].selectedCityName isEqualToString:@"杭州市"]) {
                    if (success) {
                        success(spaceListArray);
                    }
                }else {
                    NSMutableArray *tempArray = [NSMutableArray array];
                    if (success) {
                        success(tempArray);
                    }
                }
            } failed:^(NSError *error) {
                if (failed) {
                    failed(error);
                }
            }];
        } address:^(CLPlacemark *placemark) {
            [WSFSpaceListMapManager shareManager].placemark = placemark;
        } error:nil];
        
    } else {
        [SpaceDataVM getSpaceListDataWithLng:screenVC.coor.longitude lat:screenVC.coor.latitude selectTime:screenVC.currentTime duration:[screenVC.currentDuration integerValue] minPeople:screenVC.screenNumberOfPeople.minNumber maxPeople:screenVC.screenNumberOfPeople.maxNumber pageIndex:1 pageSize:1000 success:^(NSArray *spaceListArray) {
            if ([[WSFSpaceListMapManager shareManager].selectedCityName isEqualToString:@"杭州市"]) {
                if (success) {
                    success(spaceListArray);
                }
            }else {
                NSMutableArray *tempArray = [NSMutableArray array];
                if (success) {
                    success(tempArray);
                }
            }
        } failed:^(NSError *error) {
            if (failed) {
                failed(error);
            }
        }];
    }
}

+ (void)getMomentSpaceListDataWithLng:(double)lng lat:(double)lat success:(successBlock)success failed:(failedBlock)failed {
    ScreenConditionsVC *screenVC = [ScreenConditionsVC shareManager];
    [SpaceDataVM getSpaceListDataWithLng:lng lat:lat selectTime:screenVC.currentTime duration:[screenVC.currentDuration integerValue] minPeople:screenVC.screenNumberOfPeople.minNumber maxPeople:screenVC.screenNumberOfPeople.maxNumber pageIndex:1 pageSize:1000 success:^(NSArray *spaceListArray) {
        if (success) {
            success(spaceListArray);
        }
    } failed:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

- (void)resetScreenCityCondition{
    [self saveCurrentCityName:@"杭州市"];
}

#pragma mark - 保存数据
- (void)saveScreeningSpaceListArray:(NSArray *)listArray {
    _screeningSpaceListArray = listArray;
}

- (void)saveCurrentCityName:(NSString *)cityName{
    _selectedCityName = cityName;
}

- (void)saveRegionData:(NSArray<WSFCityArrayModel *> *)regionArray {
    _regionArray = regionArray;
}

- (void)getCurrentCityInformationWithBlock:(void (^)(CLPlacemark * _Nonnull))informatBlock {
    if (_placemark) {
        if(informatBlock)informatBlock(_placemark);
    }else {
        [[MapPositionManager sharedLocationManager] getCurrentCityNameWithBlack:^(CLPlacemark *placemark) {
            _placemark = placemark;
            if(informatBlock)informatBlock(placemark);
        }];
    }
}

#pragma mark - 跳转
- (void)pushToScreenVCFormVC:(UIViewController *)VC completeBlock:(screenVCCompleteBlock)completeBlock {
    [VC.navigationController pushViewController:[ScreenConditionsVC shareManager] animated:NO];
    // 将筛选条件回调回来
    [ScreenConditionsVC shareManager].completeScreeningBlock = ^{
        self.screenCoor = [ScreenConditionsVC shareManager].coor;
        self.screenAddressStr = [ScreenConditionsVC shareManager].locationStr;
        self.inScreen = [ScreenConditionsVC shareManager].isInScreen;
        [_reminderView updateReminder:[self ryj_reminderString]];
        if ([self ryj_reminderString].length > 0) {
            [_reminderView changeScreenReminderViewWithType:WSFScreenReminderViewType_Show];
        }else {
            [_reminderView changeScreenReminderViewWithType:WSFScreenReminderViewType_Hidden];
        }
        if (completeBlock) {
            completeBlock();
        }
    };
    // 重置回调回来
    [ScreenConditionsVC shareManager].resetScreeningBlock = ^{
        self.screenCoor = [ScreenConditionsVC shareManager].coor;
        self.screenAddressStr = [ScreenConditionsVC shareManager].locationStr;
        self.inScreen = [ScreenConditionsVC shareManager].isInScreen;
        [_reminderView changeScreenReminderViewWithType:WSFScreenReminderViewType_Hidden];
        if (_resetBlock) {
            _resetBlock();
        }
    };
}

- (void)pushToMapVCFormVC:(UIViewController *)VC mapVCBack:(mapVCBackBlock)mapVCBack {
    BaiduMapVC *mapVC = [[BaiduMapVC alloc] init];
    [VC.navigationController pushViewController:mapVC animated:NO];
    mapVC.popLastBlock = ^{
        if (mapVCBack) {
            mapVCBack(_screeningSpaceListArray);
        }
    };
}

- (void)pushToCityVCFormVC:(UIViewController *)VC cityVCBack:(cityVCBackBlock)cityVCBack {
    WSFCityChooseVC *cityVC = [[WSFCityChooseVC alloc] init];
    [VC.navigationController pushViewController:cityVC animated:NO];
    cityVC.cityNameBlack = ^(NSString *cityName) {
        if (![_selectedCityName isEqualToString:cityName]) {
//            [[ScreenConditionsVC shareManager] resetControllersAction];
            [ScreenConditionsVC shareManager].resetPlacemark = ^(CLPlacemark *placemark) {
                _placemark = placemark;
            };
        }
        [self saveCurrentCityName:cityName];
        if(cityVCBack)cityVCBack(cityName);
    };
}

#pragma mark - 事件响应
- (void)resetButtonClick:(NSNotification *)sender {
    [[ScreenConditionsVC shareManager] resetControllersAction];
}

#pragma mark - 私有方法
- (NSString *)ryj_reminderString {
    ScreenConditionsVC *screenVC = [ScreenConditionsVC shareManager];
    if ([screenVC.currentTime isEqualToString:@""]) {
        if (screenVC.screenNumberOfPeople.minNumber == screenVC.screenNumberOfPeople.maxNumber) { // 只显示地址
            NSString *str = [NSString stringWithFormat:@"%@",screenVC.locationStr];
            return str;
        } else { // 显示人数和地址
            NSString *str = [NSString stringWithFormat:@"%i-%i人·%@",screenVC.screenNumberOfPeople.minNumber,screenVC.screenNumberOfPeople.maxNumber,screenVC.locationStr];
            return str;
        }
    } else {
        if (screenVC.screenNumberOfPeople.minNumber == screenVC.screenNumberOfPeople.maxNumber) { // 显示时间和地址
            NSString *str = [NSString stringWithFormat:@"%@ %@小时·%@",[self ryj_conversioncTimeWithTimeString:screenVC.currentTime],screenVC.currentDuration,screenVC.locationStr];
            return str;
        } else { // 全显示
            NSString *str = [NSString stringWithFormat:@"%@ %@小时·%i-%i人·%@",[self ryj_conversioncTimeWithTimeString:screenVC.currentTime],screenVC.currentDuration,screenVC.screenNumberOfPeople.minNumber,screenVC.screenNumberOfPeople.maxNumber,screenVC.locationStr];
            return str;
        }
    }
}

- (NSString *)ryj_conversioncTimeWithTimeString:(NSString *)timeString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSDate *date = [formatter dateFromString:timeString];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM月dd日 HH:mm";
    return [fmt stringFromDate:date];
}

#pragma mark - 懒加载
- (WSFScreenReminderView *)reminderView {
    if (!_reminderView) {
        _reminderView = [[WSFScreenReminderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35) reminder:[self ryj_reminderString]];
    }
    return _reminderView;
}

@end
