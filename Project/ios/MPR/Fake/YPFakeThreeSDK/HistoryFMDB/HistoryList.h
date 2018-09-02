//
//  HistoryList.h
//  DanXinBen
//
//  Created by Jiangwei on 14/11/3.
//  Copyright (c) 2014年 Jiangwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "TrackModel.h"

@interface HistoryList : NSObject
{
    FMDatabase *_db;
}

//创建单例
+ (HistoryList *)sharedManager;

//创建数据库
-(void)createDataBase;

//保存一条记录
-(void)saveContent:(TrackModel *)trackModel;

//修改节目信息
-(void)mergeWithContent:(TrackModel *)trackModel;

//获取收听历史列表数据
-(NSArray *)getHistoryListData;

//更新播放model
-(TrackModel *)updateModel:(TrackModel *)model;

@end
