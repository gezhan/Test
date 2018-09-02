//
//  WSFUploadImageApi.m
//  WinShare
//
//  Created by devRen on 2017/12/6.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFUploadImageApi.h"
#import "WSFUploadImageModel.h"

@interface WSFUploadImageApi ()

@property (nonatomic, assign) double uploadProgress;
@property (nonatomic, strong) NSMutableArray<WSFUploadImageModel *>* imageModelArray;

@end

@implementation WSFUploadImageApi

- (NSMutableArray *)imageModelArray {
    if (!_imageModelArray) {
        _imageModelArray = [[NSMutableArray alloc] init];
    }
    return _imageModelArray;
}

- (void)uploadWithImageArray:(NSArray<UIImage *> *)imageArray
             overallProgress:(void (^)(CGFloat progress))overallProgress
                     success:(void (^)(NSArray<WSFUploadImageModel *> *model))success
                     failure:(void (^)(NSString * msg))failure {
    
    if (imageArray.count == 0) {
        if (overallProgress) overallProgress(1.0);
        if (success) success(self.imageModelArray);
        return;
    }
    
    _uploadProgress = 0.0;
    for (UIImage *image in imageArray) {
        [WSFUploadImageApi upload:image progress:^(CGFloat progress) {
            if (progress == 1.0) {
                _uploadProgress += progress;
            }
            
            if (overallProgress) overallProgress(_uploadProgress / imageArray.count);
            
        } success:^(WSFUploadImageModel * _Nonnull model) {
            [self.imageModelArray addObject:model];
            if (_uploadProgress / imageArray.count == 1.0) {
                if (success) success(self.imageModelArray);
            }
        } failure:^(NSString * _Nonnull msg) {
            if (failure) failure(msg);
        }];
    }
}

+ (void)upload:(UIImage *)image
      progress:(void (^)(CGFloat progress))progress
       success:(void(^)(WSFUploadImageModel * model))success
       failure:(void (^)( NSString * msg))failure {
    
    NSString * fileName = [NSString stringWithFormat:@"%@%@",@"666",@".jpeg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    [WSFUploadImageApi urlForUploadImageAndVoiceWithToken:[WSFUserInfo getToken] data:imageData fileName:fileName handler:^(NSString *url, NSDictionary *params) {
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) progress(uploadProgress.fractionCompleted);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject = %@",responseObject);
            WSFUploadImageModel *listModel = [MTLJSONAdapter modelOfClass:WSFUploadImageModel.class fromJSONDictionary:responseObject[@"Data"] error:nil];
             if (success) success(listModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString * msg = error.localizedDescription ;
            if (msg == nil) msg = @"未知错误" ;
            if (failure) failure(msg);
        }];
    }];
}

+ (void)urlForUploadImageAndVoiceWithToken:(NSString *)token data:(NSData *)data  fileName:(NSString *)fileName handler:(void(^)(NSString * url , NSDictionary * params ))handler {
    NSString * httpString = [NSString stringWithFormat:@"%@/api/file/FileUpload",BaseUrl];
    httpString = [httpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * mulDict = [NSMutableDictionary dictionary];
    
    if (data.length > 0) {
        NSString * dataBase64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [mulDict setObject:dataBase64String forKey:@"Data"];
        [mulDict setObject:@(data.length) forKey:@"Size"];
    }
    if (fileName.length > 0) [mulDict setObject:fileName forKey:@"FileName"];
    
    if (handler) handler(httpString , mulDict );
}

@end
