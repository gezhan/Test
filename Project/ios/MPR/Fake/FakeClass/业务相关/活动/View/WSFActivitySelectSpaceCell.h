//
//  WSFActivitySelectSpaceCell.h
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 商家--选择活动的空间列表Cell
 */
@interface WSFActivitySelectSpaceCell : UITableViewCell

@property (nonatomic, strong) UIImageView *sapceImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *selectBtn;

@end
