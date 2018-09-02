//
//  ShopListModel.h
//  WinShare
//
//  Created by QIjikj on 2017/7/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SpacePhotoModel;

typedef NS_ENUM(NSInteger, ShopListModelType) {
    ShopListModelType_smallRoom = 1,    // 小包厢
    ShopListModelType_bigroom           // 大场地
};

@interface ShopListModel : NSObject

@property (nonatomic, assign) ShopListModelType shopListModelType;//订单的类型
@property (nonatomic, copy) NSString *roomId;//空间编号
@property (nonatomic, copy) NSString *roomName;//空间名称
@property (nonatomic, copy) NSString *roomType;//空间类别
@property (nonatomic, assign) NSInteger capacity;//可容纳人数
@property (nonatomic, assign) NSInteger areaSize;//建筑面积 单位 平方米
@property (nonatomic, assign) NSInteger price;//价格
@property (nonatomic, copy) NSString *address;//空间地址
@property (nonatomic, strong) SpacePhotoModel *spacePhotoModel;//图片
@property (nonatomic, assign) CGFloat incomeAmount;//已经收入，实际收入，现在包含赢贝
@property (nonatomic, assign) CGFloat expectedAmount;//预计收入，为结算订单的定金
@property (nonatomic, assign) BOOL waitOnline;//即将上线

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (ShopListModel *)modelFromDict:(NSDictionary *)dict;
+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array;

@end
