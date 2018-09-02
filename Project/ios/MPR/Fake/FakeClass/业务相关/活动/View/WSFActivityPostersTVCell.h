//
//  WSFActivityPostersTVCell.h
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 商家 - 图片选择的tableViewCell
 */
@interface WSFActivityPostersTVCell : UITableViewCell
@property (nonatomic, strong) UIImageView *photo;     //照片
@property (nonatomic, strong) UIButton *deleteBtn;    //删除按钮
@end
