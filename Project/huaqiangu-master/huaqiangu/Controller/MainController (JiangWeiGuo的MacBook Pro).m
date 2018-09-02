//
//  MainController.m
//  huaqiangu
//
//  Created by Jiangwei on 15/7/18.
//  Copyright (c) 2015年 Jiangwei. All rights reserved.
//

#import "MainController.h"
#import "TrackModel.h"
#import "PlayController.h"
#import "DownController.h"
#import "MainList.h"

#define COUNT 30

@interface MainController ()
{
    NSInteger pageId;
    NSInteger totalPage;
    NSString *albumTitle;
    UIButton *playBtn;
    NSInteger totalTracks;
    NSString *orderStr;
}

@end

@implementation MainController

static NSInteger i = 0;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.mainTbView.backgroundColor = RGB(230, 227, 219);
    self.navigationController.navigationBarHidden = NO;
    
    [self.mainTbView reloadData];
    [self playAnimation];
}

-(void)scrollViewToIndex
{
    if (i == 0) {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:[CommUtils getPlayIndex] inSection:0];
        [self.mainTbView scrollToRowAtIndexPath:scrollIndexPath
                               atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        i++;
    }
}

#pragma mark - 
#pragma mark - 播放动画

-(void)playAnimation
{
    if (!playBtn) {
        playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    if (IS_IOS_7) {
        playBtn.frame = CGRectMake(mainscreenwidth - 50,0, 40, 40);
    }else{
        playBtn.frame = CGRectMake(mainscreenwidth - 50,20, 40, 40);
    }
    playBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    [playBtn setImage:[UIImage imageNamed:@"play_1"] forState:UIControlStateNormal];
    [CommUtils navigationPlayButtonItem:playBtn];
    
    [playBtn addTarget:self action:@selector(playingAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:playBtn];
}

#pragma mark - 
#pragma mark - 初始化排序和下载按钮
-(void)initDownOrderAction
{
    [self.downBtn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [self.orderBtn setBackgroundImage:[UIImage imageNamed:orderStr] forState:UIControlStateNormal];
    
    [self.downBtn addTarget:self action:@selector(downAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderBtn addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 
#pragma mark - 下载按钮触发方法
-(void)downAction
{
    DownController *downVC = [DownController sharedManager];
    KKNavigationController *nacVC = [[KKNavigationController alloc] initWithRootViewController:downVC];
    [nacVC.navigationBar setBarTintColor:kCommenColor];
    [self.navigationController presentViewController:nacVC animated:YES completion:^{
        [downVC getDownData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationItem.leftBarButtonItem = [LMButton setNavright:@"反馈" andcolor:[UIColor whiteColor] andSelector:@selector(pushAppStore) andTarget:self];
    self.navigationItem.leftBarButtonItem = [LMButton setNavleftButtonWithImg:@"feedback" andSelector:@selector(pushAppStore) andTarget:self];
    self.navigationItem.titleView = [CommUtils navTittle:ALBUMTITLE];
    
    pageId = 1;
    _mainMuArray = [NSMutableArray arrayWithCapacity:0];
    _downMuArray = [NSMutableArray arrayWithCapacity:0];

    self.mainTbView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight - 50);
    orderStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"orderStr"];
    if (!orderStr) {
        orderStr = @"true";
    }

    [self getMainData];
    
    self.footView.frame = CGRectMake(0, mainscreenhight - 50, mainscreenwidth, 50);
    self.footView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.footView];
    
    UIColor *comColor = [UIColor whiteColor];
    NSDictionary *colorAttr = [NSDictionary dictionaryWithObject:comColor forKey:NSForegroundColorAttributeName];
    [self.chooseSeg setTitleTextAttributes:colorAttr forState:UIControlStateNormal];
    self.chooseSeg.tintColor = [UIColor whiteColor];
    [self.chooseSeg addTarget:self action:@selector(didClicksegmentedControlAction:)forControlEvents:UIControlEventValueChanged];
    
    [self initDownOrderAction];
    
    [self setFrameView];
    
    //上下一曲通知更新列表
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reloadMainList) name: @"reloadAction" object: nil];
    
    self.orderBtn.hidden = YES;
}

#pragma mark - 给好评

-(void)pushAppStore
{
    NSString * url;
    if (IS_IOS_7) {
        url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", AppStoreAppId];
    }
    else{
        url=[NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",AppStoreAppId];
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)setFrameView
{
    [self.downBtn setAdjustsImageWhenHighlighted:NO];
    [self.orderBtn setAdjustsImageWhenHighlighted:NO];
    
    self.downBtn.frame = CGRectMake(10 * VIEWWITH, 8 * VIEWWITH, 30 * VIEWWITH, 30 * VIEWWITH);
    self.orderBtn.frame = CGRectMake(287 * VIEWWITH, 13 * VIEWWITH, 23 * VIEWWITH, 23 * VIEWWITH);
    self.chooseSeg.frame = CGRectMake(120 * VIEWWITH, 11 * VIEWWITH, 81 * VIEWWITH, 29 * VIEWWITH);
}

-(void)reloadMainList
{
    [self.mainTbView reloadData];
}


#pragma mark - 
#pragma mark - 正在播放
-(void)playingAction
{
    //判断网络环境，数据流量下不播放
    if ([CommUtils checkNetworkStatus] != ReachableViaWiFi) {
        [UIAlertView showWithTitle:@"温馨提示" message:@"当前处于非Wi-Fi网络，在线播放可能会消耗您的流量，是否继续？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"继续"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == [alertView cancelButtonIndex]) {
                return ;
            }else{
                [self pushPlayVC:[CommUtils getPlayIndex]];
            }
        }];
    }else{
        [self pushPlayVC:[CommUtils getPlayIndex]];
    }
}

-(void)getDownArray{
    
    self.mainTbView.footer = nil;
    
    NSMutableArray *downArray = [NSMutableArray arrayWithCapacity:0];
    self.mainMuArray = [NSMutableArray arrayWithArray:[[MainList sharedManager] getMainArray]];
    
    for (int i = 0; i < self.mainMuArray.count; i++) {
        TrackModel *track = self.mainMuArray[i];
        if ([track.downStatus isEqualToString:@"done"]) {
            [downArray addObject:track];
        }
    }
    
    [self.mainMuArray removeAllObjects];
    self.mainMuArray = [NSMutableArray arrayWithArray:downArray];
    [self.mainTbView reloadData];
}

#pragma mark -
#pragma mark - UISegmentedControl 方法

-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %li", (long)Index);
    switch (Index) {
        case 0:{
            [self getMainData];
        }
            break;
        case 1:{
            [self getDownArray];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 排序
-(void)orderAction
{
    NSInteger playIndex = [CommUtils getPlayIndex];
    if ([orderStr isEqualToString:@"false"]) {
        orderStr = @"true";
    }else{
        orderStr = @"false";
    }
    [CommUtils saveIndex:(totalTracks - 1 - playIndex)];
    [[NSUserDefaults standardUserDefaults] setObject:orderStr forKey:@"orderStr"];
    pageId = 1;
    [self getNetData];
    
    [self.orderBtn setBackgroundImage:[UIImage imageNamed:orderStr] forState:UIControlStateNormal];
}

//上拉刷新
-(void)loadMoreData
{
    if (pageId < totalPage) {
        pageId ++;
        [self getNetData];
    }else{
        [self.mainTbView.footer noticeNoMoreData];
    }
}


//#pragma mark - 
//#pragma mark - 获取首页数据

-(void)getMainData
{
    self.mainTbView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadMoreData];
    }];
    
     self.mainMuArray = [NSMutableArray arrayWithArray:[[MainList sharedManager] getMainArray]];
    if (self.mainMuArray.count != 0) {
        pageId = ceilf((float)self.mainMuArray.count / COUNT);
        totalPage = pageId + 1;
        
        [self.mainTbView reloadData];
        [self scrollViewToIndex];
        
    }else{
        [self getNetData];
        
    }
}

-(void)getNetData
{
    if (pageId == 1) {
        [self.mainMuArray removeAllObjects];
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",@(pageId),@(COUNT)];
    NSString *postStr = [NSString stringWithFormat:@"%@%@/%@%@",kMainHeader,orderStr,urlStr,kDevice];
    
    __weak typeof(self) bSelf = self;
    [AFService postMethod:postStr andDict:nil completion:^(NSDictionary *results,NSError *error){
        
        totalTracks = [[[results objectForKey:@"album"] objectForKey:@"tracks"] integerValue];
        
        totalPage = [[[results objectForKey:@"tracks"] objectForKey:@"maxPageId"] integerValue];
        
        NSArray *arr = [[results objectForKey:@"tracks"] objectForKey:@"list"];

        for (int i = 0; i < arr.count; i++) {
            TrackModel *track = [[TrackModel alloc]initWithDict:arr[i]];
            track.downStatus = @"on";
//            NSString *strTitle = [NSString stringWithFormat:@"步步惊心%@",track.title];
//            track.title = strTitle;
            track.orderStr = [NSString stringWithFormat:@"%lu",(pageId-1)*COUNT + (i+1)];
            
            [[MainList sharedManager] saveContent:track];
            
            //折中解决方案：本地判断最后一页时，不新增数据
            if (pageId < totalPage || pageId == totalPage) {
                [bSelf.mainMuArray addObject:track];
            }
        }
        
        [bSelf.mainTbView reloadData];
        [bSelf.mainTbView.footer endRefreshing];
        
        if (bSelf.mainMuArray.count != 0) {
            if (bSelf.mainMuArray.count > [CommUtils getPlayIndex]) {
                [bSelf scrollViewToIndex];
            }else{
                [self loadMoreData];
            }
        }
    }];
}

#pragma mark - tableview代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainMuArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = RGB(230, 227, 219);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    TrackModel *track = self.mainMuArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = track.title;
    if (indexPath.row == [CommUtils getPlayIndex]) {
        cell.textLabel.textColor = kCommenColor;
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TrackModel *track = self.mainMuArray[indexPath.row];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:HSFileFullpath(track.playUrl64)]){
        [self pushPlayVC:indexPath.row];
    }else if ([CommUtils checkNetworkStatus] != ReachableViaWiFi) {
        [UIAlertView showWithTitle:@"温馨提示" message:@"当前处于非Wi-Fi网络，在线播放可能会消耗您的流量，是否继续？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"继续"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == [alertView cancelButtonIndex]) {
                return ;
            }else{
                [self pushPlayVC:indexPath.row];
            }
        }];
    }else{
        [self pushPlayVC:indexPath.row];
    }
}

-(void)pushPlayVC:(NSInteger)indexPlay
{
    PlayController *playVC = [PlayController sharedPlayController];
    playVC.hidesBottomBarWhenPushed = YES;
    if (self.mainMuArray.count != 0) {
        [playVC pushArr:self.mainMuArray andIndex:indexPlay];
    }
    [self.navigationController pushViewController:playVC animated:YES];
}


@end
