//
//  WSFActivityIntroduceListTVM.h
//  WinShare
//
//  Created by QIjikj on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 商家--活动介绍tableCellVM
 */
@interface WSFActivityIntroduceListTCellVM : NSObject

/** 标题*/
@property (nonatomic, copy) NSString *introduceTitle;
/** 内容*/
@property (nonatomic, copy) NSString *introduceContent;

@end


/**
 活动介绍tableVM
 */
@interface WSFActivityIntroduceListTVM : NSObject

@property (nonatomic, strong) NSMutableArray<WSFActivityIntroduceListTCellVM *> *activityIntroduceListTCellVMArray;

/** 开始模式使用*/
- (instancetype)initWithNULL;

@end
