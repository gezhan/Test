//
//  ShopCardVC.m
//  WinShare
//
//  Created by QIjikj on 2017/8/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardVC.h"
#import "ShopCardTView.h"
#import "ShopCardDataVM.h"
#import "ShopCardListModel.h"

@interface ShopCardVC ()

@property (nonatomic, strong) ShopCardTView *shopCardTView;

@end

@implementation ShopCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationContent];
    
    [self.view addSubview:self.shopCardTView];
    
    [self getShopCardListDataFromWeb];
}

- (void)getShopCardListDataFromWeb
{
    
    [ShopCardDataVM getShopCardListDataSuccess:^(NSArray *shopCardList) {
        
        NSLog(@"%@", shopCardList);
        
        NSArray *shopCardListDataArr = [ShopCardListModel getModelArrayFromModelArray:shopCardList];
        self.shopCardTView.cardListArray = shopCardListDataArr;
        
    } failed:^(NSError *error) {
        
        
        NSLog(@"%@", error);
        
        
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]);
        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getShopCardListDataFromWeb];
        }];
        
    }];
}

- (void)setupNavigationContent
{
    self.navigationItem.title = @"商铺卡";
}

- (ShopCardTView *)shopCardTView
{
    if (!_shopCardTView) {
        _shopCardTView = [[ShopCardTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    return _shopCardTView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
