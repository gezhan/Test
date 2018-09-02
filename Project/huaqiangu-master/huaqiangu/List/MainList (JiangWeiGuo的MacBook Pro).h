//
//  MainList.h
//  huaqiangu
//
//  Created by JiangWeiGuo on 16/2/25.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainList : NSObject
{
    FMDatabase *_db;
}

+ (MainList *)sharedManager;

//创建数据库
-(void)createDataBase;

//保存一条记录
-(void)saveContent:(TrackModel *)trackModel;

//删除一条记录
-(void)deleteContent:(TrackModel *)trackModel;

//修改节目信息
-(void)mergeWithContent:(TrackModel *)trackModel;

//获取正在下载节目数据
-(NSArray *)getDowningData;

//获取下载完成数据信息；
-(NSArray *)getDownedData:(NSNumber *)album_id;

//判断是否已下载
-(BOOL)exist:(NSInteger)track_id;

//获取下载完成专辑
-(NSArray *)getAlbumData;

@end
