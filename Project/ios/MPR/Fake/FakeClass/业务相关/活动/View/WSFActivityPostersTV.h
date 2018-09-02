//
//  WSFActivityPostersTV.h
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>



/**  要删除的图片的id */
typedef void(^PhotoBlock)(NSInteger indexRow);

/**
 商家 - 图片选择的tableView
 */
@interface WSFActivityPostersTV : UITableView
@property (nonatomic, strong) NSArray<UIImage *> *photoArray;  //选择的图片数组
@property (nonatomic, copy) PhotoBlock photoBlock;
@end
