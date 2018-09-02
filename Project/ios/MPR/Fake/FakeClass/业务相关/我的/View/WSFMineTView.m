//
//  WSFMineTView.m
//  WinShare
//
//  Created by QIjikj on 2018/2/3.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFMineTView.h"
#import "AboutViewController.h"
#import "TheLoginVC.h"
#import "TicketViewController.h"
#import "ChinaByteViewController.h"
#import "ShopListVC.h"
#import "InvitationVC.h"// 邀请二维码
#import "AppDelegate.h"
#import "RecommendVC.h"// 推荐有礼
#import "WSFHomePageVC.h"
#import "WSFOpinionBackVC.h"// 意见反馈

@interface WSFMineTView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) NSArray *menuIconArray;
@end

@implementation WSFMineTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - tableViewDataSource,UITableViewDelegate

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuArray.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineCell"];
    }
    NSString *menuName = [self.menuArray objectAtIndex:indexPath.row];
    cell.textLabel.text = menuName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:self.menuIconArray[indexPath.row]];
    if ([menuName isEqualToString:@"清除缓存"]) {
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
        [cell.detailTextLabel setTextColor:[UIColor colorWithHexString:@"1a1a1a" alpha:0.5]];
        cell.detailTextLabel.text = [self cacheSizeFormat];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//当已经点击cell时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *selectText = cell.textLabel.text;
    
    if ([selectText isEqualToString:@"赢贝"]) {
        ChinaByteViewController *chinaByteVC = [[ChinaByteViewController alloc] init];
        [self.viewController.navigationController pushViewController:chinaByteVC animated:NO];
        
    }else if ([selectText isEqualToString:@"优惠券"]) {
        TicketViewController *ticketVC = [[TicketViewController alloc] init];
        [self.viewController.navigationController pushViewController:ticketVC animated:NO];
        
    }else if ([selectText isEqualToString:@"我的订单"]) {

        
        
    }else if ([selectText isEqualToString:@"我的空间"]) {
        ShopListVC *shopListVC = [[ShopListVC alloc] init];
        [self.viewController.navigationController pushViewController:shopListVC animated:NO];
        
    }else if ([selectText isEqualToString:@"邀请"]) {
        InvitationVC *invatationVC = [[InvitationVC alloc] init];
        [self.viewController.navigationController pushViewController:invatationVC animated:NO];
        
    }else if ([selectText isEqualToString:@"推荐有礼"]) {
//        RecommendVC *recommendVC = [[RecommendVC alloc] init];
//        [self.viewController.navigationController pushViewController:recommendVC animated:NO];
      
    }else if ([selectText isEqualToString:@"清除缓存"]) {
        [[[SDWebImageManager sharedManager] imageCache] clearDisk];
        [[[SDWebImageManager sharedManager] imageCache] clearMemory];
        __weak typeof(self) weakSelf = self;
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), queue, ^{
            [MBProgressHUD showMessage:@"缓存清除成功"];
            [weakSelf reloadData];
        });
        
    }else if ([selectText isEqualToString:@"抽奖"]) {

        
    }else if ([selectText isEqualToString:@"意见反馈"]) {
        WSFOpinionBackVC *opinionBackVC = [[WSFOpinionBackVC alloc] init];
        [self.viewController.navigationController pushViewController:opinionBackVC animated:NO];
        
    }else if ([selectText isEqualToString:@"关于我们"]) {
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        [self.viewController.navigationController pushViewController:aboutVC animated:NO];
        
    }else if ([selectText isEqualToString:@"退出当前帐号"]) {
        SureOrCancleVC *sureVC = [[SureOrCancleVC alloc] init];
        __weak typeof(self) weakSelf = self;
        sureVC.clickSureBlock = ^(void) {
            
            [weakSelf exitAction];
        };
        sureVC.titleStr = @"是否确定退出当前账号?";
        sureVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        //淡出淡入
        sureVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        sureVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self.viewController.navigationController presentViewController:sureVC animated:NO completion:nil];
    }
    
}

// 获取SDWebImage的缓存大小
- (NSString *)cacheSizeFormat
{
    NSString *sizeUnitString;
    float size = [SDWebImageManager.sharedManager.imageCache getSize];
    if(size < 1024){
        
        sizeUnitString = [NSString stringWithFormat:@"%.1fb",size];
        
    }else if (size > 1024 && size < 1024 * 1024) {
        
        size /= 1024.0;
        sizeUnitString = [NSString stringWithFormat:@"%.1fkb",size];
    }
    else{
        
        size /= (1024.0 * 1024);
        sizeUnitString = [NSString stringWithFormat:@"%.1fM",size];
    }
    
    return sizeUnitString;
}

/** UIScrollViewDelegate */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = self.contentOffset;
    if (point.y < 0) {
        //不可以向下滑动
        self.contentOffset = CGPointMake(0, 0);
    }
}

// 退出登录
- (void)exitAction {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"everLogin"];
    TheLoginVC *loginVC = [[TheLoginVC alloc]init];
    NSArray *controllerArray = self.viewController.navigationController.viewControllers;
    if (controllerArray.count > 1 && [[controllerArray objectAtIndex:controllerArray.count - 2] isKindOfClass:[WSFHomePageVC class]]) {
        loginVC.loginType = WSFPopType_PopRootType;
    }else {
        loginVC.loginType = WSFPopType_PopLastTwoLayerType;
    }
    [self.viewController.navigationController pushViewController:loginVC animated:NO];
    
    
    /**  清除缓存数据 */
    [WSFUserInfo emptyDataAction];
    
}

// 模拟关闭软件效果
- (void)exitApplication
{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = appdelegate.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
        
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

#pragma mark - 懒加载
- (NSArray *)menuArray
{
    if (!_menuArray) {
//      _menuArray = @[@"我的空间", @"推荐有礼", @"意见反馈", @"关于我们"];
        _menuArray = @[@"我的空间", @"意见反馈", @"关于我们"];
    }
    return _menuArray;
}

- (NSArray *)menuIconArray {
    if (!_menuIconArray) {
        _menuIconArray = @[@"WSFMine_DingDan", @"WSFMine_KongJian", @"WSFMine_TuiJian", @"WSFMine_ChouJiang", @"WSFMine_YiJianFanKui", @"WSFMine_AboutUs"];
    }
    return _menuIconArray;
}

@end
