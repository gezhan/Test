//
//  SearchSpaceCell.h
//  WinShare
//
//  Created by GZH on 2017/5/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PositionModel.h"

@interface SearchSpaceCell : UITableViewCell

@property (nonatomic, strong) UIImageView *locationImage;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) PositionModel *positionModel;

@end
