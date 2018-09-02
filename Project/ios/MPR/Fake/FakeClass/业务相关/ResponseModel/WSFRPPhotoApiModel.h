//
//  WSFRPPhotoApiModel.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

//#import "Mantle.h"
#import "Mantle.h"

/**
 空间照片信息
 */
@interface WSFRPPhotoApiModel : MTLModel <MTLJSONSerializing>

/** 编号*/
@property (nonatomic, copy) NSString *iid;
/** 缩略图地址*/
@property (nonatomic, copy) NSString *uRL;
/** 实际路径*/
@property (nonatomic, copy) NSString *path;
/** 文件名称*/
@property (nonatomic, copy) NSString *fileName;
/** 文件大小*/
@property (nonatomic, assign) NSInteger size;

@end
