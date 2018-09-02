//
//  DownController.h
//  huaqiangu
//
//  Created by JiangWeiGuo on 16/2/23.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *downTbView;
@property (weak, nonatomic) IBOutlet UIView *downFootView;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (nonatomic, strong) NSMutableArray *downMuArray;

@property (nonatomic, strong) NSMutableArray *downingMuArray;

+ (DownController *)sharedManager;
-(void)getDownData;
-(void)downAction;

@end
