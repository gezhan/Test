//
//  AlertBottomCell.m
//  WinShare
//
//  Created by GZH on 2017/5/13.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "AlertBottomCell.h"

@implementation AlertBottomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        
        _nameLab = [[UILabel alloc] initWithFrame:_nameLab.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _nameLab.font = [UIFont systemFontOfSize:16];
        _nameLab.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLab];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
