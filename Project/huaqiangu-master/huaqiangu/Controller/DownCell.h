//
//  DownCell.h
//  huaqiangu
//
//  Created by JiangWeiGuo on 16/2/23.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

-(void)setDownCell:(TrackModel *)track;

@end
