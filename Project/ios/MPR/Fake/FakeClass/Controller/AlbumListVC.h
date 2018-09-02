//
//  AlbumListVC.h
//  huaqiangu
//
//  Created by JiangWeiGuo on 2016/9/18.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AlbumListVC : UIViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *albumTbview;
@property (strong, nonatomic) NSMutableArray *albumMuArray;

@end
