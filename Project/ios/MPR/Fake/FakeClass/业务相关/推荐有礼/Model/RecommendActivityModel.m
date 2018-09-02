//
//  RecommendActivityModel.m
//  WinShare
//
//  Created by Gzh on 2017/9/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "RecommendActivityModel.h"

@implementation RecommendActivityModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        self.activityId = dict[@"ID"];
        self.activityTitle = dict[@"Title"];
        self.activityPicture = dict[@"Picture"];
        self.activityCode = dict[@"Code"];
        
        NSString *tempStr = [(NSArray *)dict[@"Regulation"] componentsJoinedByString:@"\n"];
        self.activityRegulation = tempStr;
        
        self.shareTitle = dict[@"ShareTitle"];
        self.shareContent = dict[@"ShareContent"];
        self.sharePicture = dict[@"SharePicture"];
        
    }
    return self;
}

+ (RecommendActivityModel *)modelFromDict:(NSDictionary *)dict
{
    RecommendActivityModel *model = [[RecommendActivityModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        RecommendActivityModel *model = [RecommendActivityModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
