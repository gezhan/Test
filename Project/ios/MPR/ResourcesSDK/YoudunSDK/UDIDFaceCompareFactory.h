//
//  UDIDFaceCompareFactory.h
//  UubeeSuperReal
//
//  Created by Jin Jian on 2017/6/7.
//  Copyright © 2017年 Hydra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UDIDFaceCompareItem.h"

@interface UDIDFaceCompareFactory : NSObject

+ (UDIDFaceCompareItem *)getByUrl:(NSString *)url;
+ (UDIDFaceCompareItem *)getByBase64:(NSString *)base64String;
+ (UDIDFaceCompareItem *)getBySessionID:(NSString *)sessionId type:(UDIDSafePhotoType)type;
+ (UDIDFaceCompareItem *)getBytype:(UDIDSafePhotoType)type;

@end
