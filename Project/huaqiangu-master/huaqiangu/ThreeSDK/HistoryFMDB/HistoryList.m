//
//  HistoryList.m
//  DanXinBen
//
//  Created by Jiangwei on 14/11/3.
//  Copyright (c) 2014年 Jiangwei. All rights reserved.
//

#import "HistoryList.h"
#import "SDBManager.h"

@implementation HistoryList

+ (HistoryList *)sharedManager
{
    static HistoryList *sharedAccountManagerInstance = nil;
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
    FMResultSet *set=[_db executeQuery:@"select count(*) from sqlite_master where type ='table' and name = 'HistoryList'"];
    [set next];
    
    NSInteger count=[set intForColumn:0];
    
    BOOL existTable=!!count;
    
    if (existTable) {
        // TODO:是否更新数据库
        //[AppDelegate showStatusWithText:@"数据库已经存在" duration:2];
    } else {
        // TODO: 插入新的数据库
        NSString * sql = @"CREATE TABLE HistoryList (uid INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,title VARCHAR(50),playUrl64 VARCHAR(50),hisProgress VARCHAR(50))";
        BOOL res = [_db executeUpdate:sql];
        if (!res) {
            //[AppDelegate showStatusWithText:@"数据库创建失败" duration:2];
        } else {
            //[AppDelegate showStatusWithText:@"数据库创建成功" duration:2];
        }
    }
}

-(void)saveContent:(TrackModel *)trackModel
{
    if ([self exist:trackModel.title])
    {
        [self mergeWithContent:trackModel];
        return;
    }
    
    NSMutableString * query = [NSMutableString stringWithFormat:@"INSERT INTO HistoryList"];
    NSMutableString * keys = [NSMutableString stringWithFormat:@" ("];
    NSMutableString * values = [NSMutableString stringWithFormat:@" ( "];
    NSMutableArray * arguments = [NSMutableArray arrayWithCapacity:100];
    if (trackModel.title) {
        [keys appendString:@"title,"];
        [values appendString:@"?,"];
        [arguments addObject:trackModel.title];
    }
    if (trackModel.playUrl64) {
        [keys appendString:@"playUrl64,"];
        [values appendString:@"?,"];
        [arguments addObject:trackModel.playUrl64];
    }
    if (trackModel.hisProgress.doubleValue) {
        [keys appendString:@"hisProgress,"];
        [values appendString:@"?,"];
        [arguments addObject:trackModel.hisProgress];
    }
    
    [keys appendString:@")"];
    [values appendString:@")"];
    [query appendFormat:@" %@ VALUES%@",
     [keys stringByReplacingOccurrencesOfString:@",)" withString:@")"],
     [values stringByReplacingOccurrencesOfString:@",)" withString:@")"]];
    //    TLog(@"%@",query);
    //[AppDelegate showStatusWithText:@"插入一条数据" duration:2.0];
    [_db executeUpdate:query withArgumentsInArray:arguments];
}

-(BOOL)exist:(NSString *)title
{
    BOOL extst=NO;
    NSString * query = @"SELECT title FROM HistoryList";
    FMResultSet * rs = [_db executeQuery:query];
    while ([rs next])
    {
        if ([title isEqualToString:[rs stringForColumn:@"title"]]) {
            extst=YES;
            break;
        }
    }
    [rs close];
    return extst;
}

-(void)mergeWithContent:(TrackModel *)trackModel
{
    NSString * query = @"UPDATE HistoryList SET";
    NSMutableString * temp = [NSMutableString stringWithCapacity:20];
    
    [temp appendFormat:@" hisProgress = '%@',",trackModel.hisProgress];
    
    [temp appendString:@")"];
    query = [query stringByAppendingFormat:@"%@ WHERE title = '%@'",[temp stringByReplacingOccurrencesOfString:@",)" withString:@""],trackModel.title];
    //    TLog(@"%@",query);
    
    //[AppDelegate showStatusWithText:@"修改一条数据" duration:2.0];
    [_db executeUpdate:query];
}

-(NSArray *)getHistoryListData
{
    NSString * query = @"SELECT title,playUrl64,hisProgress FROM HistoryList ORDER BY uid DESC";
    
    FMResultSet * rs = [_db executeQuery:query];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:[rs columnCount]];
    while ([rs next]) {
        TrackModel * model = [TrackModel new];
        model.title = [rs stringForColumn:@"title"];
        model.playUrl64 = [rs stringForColumn:@"playUrl64"];
        model.hisProgress = [rs stringForColumn:@"hisProgress"];
        
        [array addObject:model];
    }
    [rs close];
    
    return array;
}

-(TrackModel *)updateModel:(TrackModel *)model
{
    NSString * query = [NSString stringWithFormat:@"SELECT hisProgress FROM HistoryList WHERE title = '%@'",model.title];
    
    FMResultSet * rs = [_db executeQuery:query];
    while ([rs next]) {
        TrackModel * model = [TrackModel new];
        model.hisProgress = [rs stringForColumn:@"hisProgress"];
        return model;
    }
    [rs close];
    return nil;
}

@end
