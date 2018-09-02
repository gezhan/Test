//
//  WSFActivitySelectSpaceTVM.h
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 商家--选择活动的空间列表TCellViewModel
 */
@interface WSFActivitySelectSpaceCellVM : NSObject
@property (nonatomic, copy) NSString *spaceImageURL;
@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, copy) NSString *addressString;
@property (nonatomic, assign) BOOL selected;
@end


/**
 选择活动的空间列表TViewModel
 */
@interface WSFActivitySelectSpaceTVM : NSObject

@property (nonatomic, strong) NSMutableArray<WSFActivitySelectSpaceCellVM *> *activitySelectSpaceCellVMArray;

// 假数据
- (instancetype)initWithNULL;

@end
