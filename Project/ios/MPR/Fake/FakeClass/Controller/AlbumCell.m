//
//  AlbumCell.m
//  huaqiangu
//
//  Created by JiangWeiGuo on 2016/9/18.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setAlbumCellFrame];
}
-(void)setAlbumCell:(AlbumModel *)model
{
    self.albumTitle.backgroundColor = [UIColor clearColor];
    self.albumInfo.backgroundColor = [UIColor clearColor];
    self.albumImage.backgroundColor = [UIColor clearColor];

    self.albumTitle.text = model.title;
    self.albumInfo.text = model.intro;
    [self.albumImage sd_setImageWithURL:[NSURL URLWithString:model.coverLarge] placeholderImage:[UIImage imageNamed:@"renmin"]];
    self.albumInfo.userInteractionEnabled = NO;
}

-(void)setAlbumCellFrame
{
    self.albumInfo.frame = CGRectMake(98 * VIEWWITH, 40 * VIEWWITH, 214 * VIEWWITH, 43 * VIEWWITH);
    self.albumTitle.frame = CGRectMake(98 * VIEWWITH, 10 * VIEWWITH, 214 * VIEWWITH, 30 * VIEWWITH);
    self.albumImage.frame = CGRectMake(10 * VIEWWITH, 10 * VIEWWITH, 80 * VIEWWITH, 80 * VIEWWITH);
}

@end
