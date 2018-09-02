//
//  AlbumCell.h
//  huaqiangu
//
//  Created by JiangWeiGuo on 2016/9/18.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumModel.h"

@interface AlbumCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *albumImage;
@property (weak, nonatomic) IBOutlet UILabel *albumTitle;
@property (weak, nonatomic) IBOutlet UITextView *albumInfo;

-(void)setAlbumCell:(AlbumModel *)model;
@end
