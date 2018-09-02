//
//  WSFRPFileUploadApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"


/**
 文件上传应答数据
 */
@interface WSFRPFileUploadApiModel : MTLModel <MTLJSONSerializing>


/** 相关信息存储编号*/
@property (nonatomic, copy) NSString *iD;
/** 图片文件缩略图地址*/
@property (nonatomic, copy) NSString *formatUrl;
/** 原数据地址*/
@property (nonatomic, copy) NSString *rowUrl;


@end
