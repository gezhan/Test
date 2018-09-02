//
//  SpacePhotoModel.h
//  WinShare
//
//  Created by QIjikj on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpacePhotoModel : NSObject

@property (nonatomic, copy) NSString *photoFileId;
@property (nonatomic, copy) NSString *photoFileUrl;
@property (nonatomic, copy) NSString *photoFilePath;//原图路径
@property (nonatomic, copy) NSString *photoFileName;
@property (nonatomic, assign) NSInteger photoFileSize;

- (instancetype)initWithDict:(NSDictionary*)dict;

+ (SpacePhotoModel*)modelFromDict:(NSDictionary*)dict;
+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array;

@end
