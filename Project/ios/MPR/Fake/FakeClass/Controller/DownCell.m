//
//  DownCell.m
//  huaqiangu
//
//  Created by JiangWeiGuo on 16/2/23.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import "DownCell.h"

@implementation DownCell


-(void)setDownCell:(TrackModel *)track{
    
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel.text = track.title;
    self.chooseBtn.selected = track.isSelected;
    if (![track.downStatus isEqualToString:@"on"] && ![track.title isEqualToString:@"全选"]) {
        self.chooseBtn.selected = YES;
        self.userInteractionEnabled = NO;
    }else{
        self.userInteractionEnabled = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.chooseBtn.userInteractionEnabled = NO;
}


@end
