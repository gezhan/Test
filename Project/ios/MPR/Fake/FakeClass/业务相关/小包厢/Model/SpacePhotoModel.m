//
//  SpacePhotoModel.m
//  WinShare
//
//  Created by QIjikj on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpacePhotoModel.h"

@implementation SpacePhotoModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.photoFileId = dict[@"Id"];
        self.photoFileUrl = dict[@"URL"];
        self.photoFilePath = dict[@"Path"];
        self.photoFileName = dict[@"FileName"];
        self.photoFileSize = [dict[@"Size"] integerValue];
        
    }
    return self;
}

+ (SpacePhotoModel*)modelFromDict:(NSDictionary*)dict
{
    SpacePhotoModel *spacePhotoModel = [[SpacePhotoModel alloc] initWithDict:dict];
    return spacePhotoModel;
}

+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        SpacePhotoModel *model = [SpacePhotoModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
