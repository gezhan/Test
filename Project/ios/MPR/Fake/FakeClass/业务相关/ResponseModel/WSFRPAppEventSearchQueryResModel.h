//
//  WSFRPAppEventSearchQueryResModel.h
//  WinShare
//
//  Created by GZH on 2018/3/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import <Foundation/Foundation.h>
@class WSFRPAppEventSearchResModel;

@interface WSFRPAppEventSearchQueryResModel : MTLModel <MTLJSONSerializing>
/**  符合条件的记录总数量 */
@property (nonatomic, assign) NSInteger totalCount;
/**  当前第几页 */
@property (nonatomic, assign) NSInteger pageIndex;
/**  每页数量 */
@property (nonatomic, assign) NSInteger pageSize;
/**  当前页的所有记录 */
@property (nonatomic, strong) NSArray<WSFRPAppEventSearchResModel*> *records;
@end
