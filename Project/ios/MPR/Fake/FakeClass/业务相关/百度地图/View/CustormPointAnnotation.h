//
//  CustormPointAnnotation.h
//  WinShare
//
//  Created by GZH on 2017/5/15.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduHeader.h"
@class SpaceMessageModel;

@interface CustormPointAnnotation : BMKPointAnnotation
/**  点的id */
@property (nonatomic, strong) NSString *annotationID;
/**  显示空间的model */
@property (nonatomic, strong) SpaceMessageModel *model; 
/**  同一个经纬度有多个空间位置时候的model数组 */
@property (nonatomic, strong) NSMutableArray<SpaceMessageModel*> *pointCollectionArray;

@end
