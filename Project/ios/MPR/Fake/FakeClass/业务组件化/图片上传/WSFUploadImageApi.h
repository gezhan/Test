//
//  WSFUploadImageApi.h
//  WinShare
//
//  Created by devRen on 2017/12/6.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFUploadImageModel;

NS_ASSUME_NONNULL_BEGIN
@interface WSFUploadImageApi : NSObject

/**
 上传图片

 @param image 图片对象
 @param progress 上传进度
 @param success 上传成功
 @param failure 上传失败
 */
+ (void)upload:(nonnull UIImage *)image
      progress:(void (^)(CGFloat progress))progress
       success:(void(^)(WSFUploadImageModel * model))success
       failure:(void (^)(NSString * msg))failure;

/**
 批量上传图片

 @param imageArray 图片数组
 @param overallProgress 整个上传进度
 @param success 上传成功
 @param failure 上传失败
 */
- (void)uploadWithImageArray:(nonnull NSArray<UIImage *> *)imageArray
             overallProgress:(void (^)(CGFloat progress))overallProgress
                     success:(void (^)(NSArray<WSFUploadImageModel *> *model))success
                     failure:(void (^)(NSString * msg))failure;
@end
NS_ASSUME_NONNULL_END
