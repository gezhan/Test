//
//  ShopCardRecordVC.m
//  WinShare
//
//  Created by QIjikj on 2017/8/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardRecordVC.h"
#import "ShopCardDetailTVC.h"
#import "ShopCardDataVM.h"

@interface ShopCardRecordVC ()<YSLContainerViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *monthNameArray;// 有数据的月份
@end

@implementation ShopCardRecordVC

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationContent];
    
    [self getShopCardDetailAccountFromWeb];
}

#pragma mark - 获取网络数据
- (void)getShopCardDetailAccountFromWeb
{
    
    [ShopCardDataVM getShopCardDetailAccountWithRoomId:self.roomId success:^(NSArray *shopCardDetailAccount) {
        
        NSLog(@"获取有数据的月份数组成功：%@", shopCardDetailAccount);
        
        [self.monthNameArray addObjectsFromArray:shopCardDetailAccount];
        
        [self setupContentView];
        
    } failed:^(NSError *error) {
        
        NSLog(@"获取有数据的月份数组失败：%@", error);
        
        
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]);
        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getShopCardDetailAccountFromWeb];
        }];
        
    }];
}

#pragma mark - 基础界面搭建
- (void)setupNavigationContent
{
    self.navigationItem.title = @"使用详情";
}

- (void)setupContentView
{
    //ViewControllers
    NSMutableArray *viewControllerArray = [NSMutableArray array];
    for (int i = 0; i < self.monthNameArray.count; i ++) {
        ShopCardDetailTVC * shopCardDetailTVC = [[ShopCardDetailTVC alloc] init];
        shopCardDetailTVC.title = [self.monthNameArray objectAtIndex:i];
        shopCardDetailTVC.roomId = self.roomId;
        shopCardDetailTVC.monthNameString = [self.monthNameArray objectAtIndex:i];
        [viewControllerArray addObject:shopCardDetailTVC];
    }
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    NSLog(@"%f", (statusHeight + navigationHeight));
    
    YSLContainerViewController *containtVC = [[YSLContainerViewController alloc] initWithControllers:viewControllerArray topBarHeight:(statusHeight + navigationHeight - 64) parentViewController:self];
    containtVC.delegate = self;
    containtVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:16];
    
    [self.view addSubview:containtVC.view];
}

#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    NSLog(@"current Index : %ld",(long)index);
    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)monthNameArray
{
    if (!_monthNameArray) {
        _monthNameArray = [NSMutableArray array];
    }
    return _monthNameArray;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
