//
//  SpaceModel.h
//  WinShare
//
//  Created by GZH on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

/**  model数据可优化----------- */
@interface SpaceModel : NSObject

@property (nonatomic, strong) NSMutableArray *timeArray; //要预定的时间
@property (nonatomic, strong) NSMutableArray *dataArray; //日期(将日期换成今天明天)
@property (nonatomic, strong) NSMutableArray *pointTimeArray; //时间点

@property (nonatomic, strong) NSMutableArray *tureDataArray; //真实日期


//初始化数据
- (instancetype)initWithData;

@end
