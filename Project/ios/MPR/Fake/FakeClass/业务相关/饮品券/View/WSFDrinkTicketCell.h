//
//  WSFDrinkTicketCell.h
//  WinShare
//
//  Created by devRen on 2017/10/27.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TicketModel;

typedef NS_ENUM(NSInteger, WSFDrinkTicketCellType) {
    WSFDrinkTicketCellType_valid,   // 有效饮品券
    WSFDrinkTicketCellType_invalid  // 失效饮品券
};

@interface WSFDrinkTicketCell : UITableViewCell

/**
 根据 WSFDrinkTicketCellType 初始化 cell

 @param style UITableViewCellStyle
 @param reuseIdentifier 标识
 @param cellType cell 类型
 @return cell 对象
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(WSFDrinkTicketCellType)cellType;

/** 赋值 */
- (void)theAssignmentWithTicketModel:(TicketModel *)ticketModel;

@end
