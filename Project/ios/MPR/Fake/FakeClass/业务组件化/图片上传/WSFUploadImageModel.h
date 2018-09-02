//
//  WSFUploadImageModel.h
//  WinShare
//
//  Created by devRen on 2017/12/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "Mantle.h"

@interface WSFUploadImageModel : MTLModel<MTLJSONSerializing>

/** 图片编号 */
@property (nonatomic, copy) NSString *imageID;
/** 图片文件缩略图地址 */
@property (nonatomic, copy) NSString *formatUrl;
/** 原数据地址 */
@property (nonatomic, copy) NSString *rowUrl;

@end
