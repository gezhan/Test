//
//  WSFFieldTimeTVCell.h
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFFieldSelectedCellVM;
@class WSFFieldDetailM;
@interface WSFFieldTimeTVCell : UITableViewCell
/**  空间详情的model */
@property (nonatomic, strong) WSFFieldDetailM *detailModel;
/**  cell上边的数据 */
@property (nonatomic, strong) WSFFieldSelectedCellVM *selectedCellVM;

@end
