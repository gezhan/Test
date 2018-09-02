//
//  AlbumModel.h
//  huaqiangu
//
//  Created by JiangWeiGuo on 2016/9/18.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *albumId;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *coverLarge;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
