//
//  RecommendActivityModel.h
//  WinShare
//
//  Created by Gzh on 2017/9/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendActivityModel : HSModel

@property (nonatomic, copy) NSString *activityId;/** 活动id */
@property (nonatomic, copy) NSString *activityTitle;/** 活动标题 */
@property (nonatomic, copy) NSString *activityPicture;/** 活动的背景图片路径 */
@property (nonatomic, copy) NSString *activityCode;/** 二维码内容 */
@property (nonatomic, copy) NSString *activityRegulation;/** 活动的规则 */

@property (nonatomic, copy) NSString *shareTitle;/** 分享标题 */
@property (nonatomic, strong) NSArray *shareContent;/** 分享内容 */
@property (nonatomic, copy) NSString *sharePicture;/** 分享图片 */

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (RecommendActivityModel *)modelFromDict:(NSDictionary *)dict;
+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array;

@end
