//
//  MainList.m
//  huaqiangu
//
//  Created by JiangWeiGuo on 16/2/25.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import "MainList.h"
#import "SDBManager.h"

@implementation MainList

+ (MainList *)sharedManager
{
    static MainList *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

-(id)init{
    self=[super init];
    
    if (self) {
        //========== 首先查看有没有建立下载模块的数据库，如果未建立，则建立数据库=========
        _db=[SDBManager defaultDBManager].dataBase;
        [self createDataBase];
    }
    return self;
}

-(void)createDataBase
{
    FMResultSet *set=[_db executeQuery:@"select count(*) from sqlite_master where type ='table' and name = 'MainList'"];
    [set next];
    
    NSInteger count=[set intForColumn:0];
    
    BOOL existTable=!!count;
    
    if (existTable) {
        // TODO:是否更新数据库
        //[AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
    } else {
        // TODO: 插入新的数据库
        NSString * sql = @"CREATE TABLE MainList (uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,title VARCHAR(50),playUrl64 VARCHAR(50),hisProgress VARCHAR(100),coverLarge VARCHAR(100),downStatus VARCHAR(100),orderStr VARCHAR(100))";
        BOOL res = [_db executeUpdate:sql];
        if (!res) {
            //[AppDelegate showStatusWithText:@"数据库创建失败" duration:2];
        } else {
            //[AppDelegate showStatusWithText:@"数据库创建成功" duration:2];
        }
    }
}

#pragma mark - 
#pragma mark - 保存信息

-(void)saveContent:(TrackModel *)track
{
    if ([self exist:track.title])
    {
        [self mergeWithContent:track];
        return;
    }
    
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO MainList"];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:100];
    if (track.title) {
        [keys appendString:@"title,"];
        [values appendString:@"?,"];
        [arguments addObject:track.title];
    }
    if (track.playUrl64) {
        [keys appendString:@"playUrl64,"];
        [values appendString:@"?,"];
        [arguments addObject:track.playUrl64];
    }
    if (track.hisProgress) {
        [keys appendString:@"hisProgress,"];
        [values appendString:@"?,"];
        [arguments addObject:track.hisProgress];
    }
    if (track.coverLarge) {
        [keys appendString:@"coverLarge,"];
        [values appendString:@"?,"];
        [arguments addObject:track.coverLarge];
    }
    if (track.downStatus) {
        [keys appendString:@"downStatus,"];
        [values appendString:@"?,"];
        [arguments addObject:track.downStatus];
    }
    if (track.orderStr) {
        [keys appendString:@"orderStr,"];
        [values appendString:@"?,"];
        [arguments addObject:track.orderStr];
    }
    
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    //    NSLog(@"%@",query);
    //[AppDelegate showStatusWithText:@"插入一条数据" duration:2.0];
    [_db executeUpdate:query withArgumentsInArray:arguments];
}

#pragma mark -
#pragma mark - 删除一条数据

-(void)deleteContent:(TrackModel *)track
{
    NSString * query = [NSString stringWithFormat:@"DELETE FROM MainList WHERE title = '%@'",track.title];
    //[AppDelegate showStatusWithText:@"删除一条数据" duration:2.0];
    [_db executeUpdate:query];
}

-(void)cleanContent
{
    NSString * query = @"DELETE FROM MainList";
    //[AppDelegate showStatusWithText:@"删除一条数据" duration:2.0];
    [_db executeUpdate:query];
}

#pragma mark -
#pragma mark - 更新数据

-(void)mergeWithContent:(TrackModel *)track
{
    if (!track.title) {
        return;
    }
    NSString * query = @"UPDATE MainList SET";
    NSMutableString * temp = [NSMutableString stringWithCapacity:20];
    // xxx = xxx;
    if (track.title) {
        [temp appendFormat:@" title = '%@',",track.title];
    }
    if (track.playUrl64) {
        [temp appendFormat:@" playUrl64 = '%@',",track.playUrl64];
    }
    if (track.hisProgress) {
        [temp appendFormat:@" hisProgress = '%@',",track.hisProgress];
    }
    if (track.coverLarge) {
        [temp appendFormat:@" coverLarge = '%@',",track.coverLarge];
    }
    if (track.downStatus) {
        [temp appendFormat:@" downStatus = '%@',",track.downStatus];
    }
    if (track.orderStr) {
        [temp appendFormat:@" orderStr = '%@',",track.orderStr];
    }
    
    [temp appendString:@")"];
    query = [query stringByAppendingFormat:@"%@ WHERE title = '%@'",[temp stringByReplacingOccurrencesOfString:@",)" withString:@""],track.title];
    
    //[AppDelegate showStatusWithText:@"修改一条数据" duration:2.0];
    [_db executeUpdate:query];
}

#pragma mark - 
#pragma mark - 检测是否已录入数据库

-(BOOL)exist:(NSString *)title
{
    BOOL extst = NO;
    NSString * query = @"SELECT title FROM MainList";
    FMResultSet * rs = [_db executeQuery:query];
    while ([rs next])
    {
        if ( [title isEqualToString: [rs stringForColumn:@"title"]]) {
            extst = YES;
            break;
        }
    }
    [rs close];
    return extst;
}

-(NSArray *)getMainArray
{
    NSString * query = @"SELECT title,playUrl64,hisProgress,coverLarge,downStatus,orderStr FROM MainList";
    
    FMResultSet * rs = [_db executeQuery:query];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
    while ([rs next]) {
        TrackModel * track = [TrackModel new];
        track.title = [rs stringForColumn:@"title"];
        track.playUrl64 = [rs stringForColumn:@"playUrl64"];
        track.hisProgress = [rs stringForColumn:@"hisProgress"];
        track.coverLarge = [rs stringForColumn:@"coverLarge"];
        track.downStatus = [rs stringForColumn:@"downStatus"];
        track.orderStr = [rs stringForColumn:@"orderStr"];
        
        if (track.title)
        {
            [array addObject:track];
        }
    }
    [rs close];
    
    //数组排序
    NSArray *sortedArray = [array sortedArrayUsingComparator:^(TrackModel *obj1, TrackModel *obj2){
        if ([obj1.orderStr intValue] > [obj2.orderStr intValue]){
            return NSOrderedDescending;
        }
        if ([obj1.orderStr intValue]< [obj2.orderStr intValue]){
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    return sortedArray;
}

-(TrackModel *)updateModel:(TrackModel *)model
{
    NSString * query = [NSString stringWithFormat:@"SELECT downStatus FROM MainList WHERE title = '%@'",model.title];
    
    FMResultSet * rs = [_db executeQuery:query];
    while ([rs next]) {
        TrackModel * newModel = [TrackModel new];
        newModel.downStatus = [rs stringForColumn:@"downStatus"];
        return newModel;
    }
    [rs close];
    return nil;
}

@end
