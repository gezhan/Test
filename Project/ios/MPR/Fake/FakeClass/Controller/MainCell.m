//
//  MainCell.m
//  huaqiangu
//
//  Created by JiangWeiGuo on 16/6/6.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:16];
    self.downLabel.textColor = [UIColor darkGrayColor];
    
    [self setMainCellFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMainCellFrame
{
    self.titleLabel.frame = CGRectMake(10 * VIEWWITH, 0 * VIEWWITH, 233 * VIEWWITH, 60 * VIEWWITH);
    self.downLabel.frame = CGRectMake(250 * VIEWWITH, 0 * VIEWWITH, 50 * VIEWWITH, 60 * VIEWWITH);
}

@end
