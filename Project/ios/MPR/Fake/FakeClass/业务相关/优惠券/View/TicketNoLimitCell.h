//
//  TicketNoLimitCell.h
//  WinShare
//
//  Created by GZH on 2017/8/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TicketModel;

@interface TicketNoLimitCell : UITableViewCell

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *bgLeftImageView;
@property (nonatomic, strong) UIImageView *bgRightImageView;
@property (nonatomic, strong) UILabel *ticketTypeLabel;
@property (nonatomic, strong) UIImageView *selectedLogo;
@property (nonatomic, strong) UILabel *ticketNameLabel;
@property (nonatomic, strong) UILabel *ticketMessageLabel;
@property (nonatomic, strong) UIView *dotView;
@property (nonatomic, strong) UILabel *ticketMessageOtherLabel;
@property (nonatomic, strong) UIView *dotOtherView;

@property (nonatomic, strong) NSMutableArray *ticketMessageLabelArray;//存放优惠券说明的label的数组
@property (nonatomic, strong) NSMutableArray *ticketDotViewLabelArray;//存放优惠券说明前的小点的数组

@property (nonatomic, strong) TicketModel *ticketModel;

- (void)setupViewContent;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier limitCount:(NSInteger)limitCount;

@end
