//
//  MainController.h
//  huaqiangu
//
//  Created by Jiangwei on 15/7/18.
//  Copyright (c) 2015年 Jiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainController : UIViewController<UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate>{
    GADBannerView *adBannerView;
}

@property (weak, nonatomic) IBOutlet UITableView *mainTbView;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseSeg;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (nonatomic, strong) NSMutableArray *mainMuArray;
@property (nonatomic, strong) NSMutableArray *downMuArray;
@property (nonatomic, strong) NSMutableArray *needDownMuArray;

@property (nonatomic, copy) NSString *albumID;
@property (nonatomic, copy) NSString *albumTitle;
@property (nonatomic, copy) NSString *albumImage;

@end
