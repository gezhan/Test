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
#import "MainCell.h"
#import "HSDownloadManager.h"

#define COUNT 30

@interface MainController ()<BaiduMobAdViewDelegate>
{
    NSInteger pageId;
    NSInteger totalPage;
//    NSString *albumTitle;
    NSInteger totalTracks;
    NSString *orderStr;
    DownloadState downStatus;
    UIButton *playBtn;
    BaiduMobAdView *sharedAdView;
}

@end

@implementation MainController

static NSInteger i = 0;
//static NSInteger j = 0;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self admobAD];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.mainTbView reloadData];
    
    NSLog(@"downStatus = %u", downStatus);
    if (downStatus !=  DownloadStateStart) {
        [self automaticDownloads];
    }
    
    [self playAnimation];
    
//    [self addBaiDuAdView];
}

-(void)dealloc
{
    [sharedAdView removeFromSuperview];
    sharedAdView.delegate = nil;
    sharedAdView = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    sharedAdView = nil;
    adBannerView = nil;
}

-(void)addBaiDuAdView
{
    if (!sharedAdView) {
        //使用嵌入干告的方法实例。
        sharedAdView = [[BaiduMobAdView alloc] init]; //把在mssp.baidu.com上创建后获得的代码位id写到这里
        sharedAdView.AdUnitTag = ADUNITTAGBANNER;
        sharedAdView.AdType = BaiduMobAdViewTypeBanner;
        sharedAdView.frame = CGRectMake(0, mainscreenhight - 50, mainscreenwidth, 50);
        //    sharedAdView.frame = kAdViewPortraitRect;
        sharedAdView.delegate = self;
        [self.view addSubview:sharedAdView];
        [sharedAdView start];
    }
}

#pragma mark - admob广告

-(void)admobAD
{
    adBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    adBannerView.frame = CGRectMake(0, mainscreenhight - 50, mainscreenwidth, 50);
    adBannerView.adUnitID = KadMobKey;
    adBannerView.delegate = self;
    adBannerView.rootViewController = self;
    [self.view addSubview:adBannerView];
    
    GADRequest *request = [GADRequest request];
    // Requests test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADBannerView automatically returns test ads when running on a
    // simulator.
//    request.testDevices = @[
//                            @"2077ef9a63d2b398840261c8221a0c9a"  // Eric's iPod Touch
//                            ];
    [adBannerView loadRequest:request];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    bannerView.hidden = NO;
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", error.localizedDescription);
}



- (NSString *)publisherId {
    return PUBLISHERID; //@"your_own_app_id";
}

-(void) willDisplayAd:(BaiduMobAdView*) adview {
    NSLog(@"delegate: will display ad");
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

-(void)backAction
{
    LM_POP;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self admobAD];

    self.view.backgroundColor = RGB(230, 227, 219);
    self.mainTbView.backgroundColor = RGB(230, 227, 219);

    self.navigationItem.titleView = [CommUtils navTittle:self.albumTitle];
    
    self.navigationItem.leftBarButtonItem = [LMButton setNavleftButtonWithImg:@"back" andSelector:@selector(backAction) andTarget:self];


//    [self registerLocalNotification:2016];
    downStatus = DownloadStateCompleted;//初始化下载状态
    
    pageId = 1;
    _mainMuArray = [NSMutableArray arrayWithCapacity:0];
    _downMuArray = [NSMutableArray arrayWithCapacity:0];
    _needDownMuArray = [NSMutableArray arrayWithCapacity:0];

    self.mainTbView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight- 50);
    orderStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"orderStr"];
    if (!orderStr) {
        orderStr = @"true";
    }

    if ([CommUtils checkNetworkStatus] == NotReachable) {
        [self getDownArray];
    }else{
        [self getNetData];
    }
    
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
    
    self.mainTbView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        pageId = 1;
        [self getNetData];
    }];
    
    [self.mainTbView.header beginRefreshing];
    
    self.mainTbView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadMoreData];
    }];
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
    
//    self.mainTbView.footer = nil;
    
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

- (NSString *)fixStringForDate:(NSDate *)date

{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *fixString = [dateFormatter stringFromDate:date];
    
    return fixString;
    
}

#pragma mark - 注册本地通知

- (void)registerLocalNotification:(NSInteger)alertTime {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    NSLog(@"dateFormatter===%@",[self fixStringForDate:[NSDate date]]);
    
//    notification.fireDate = fireDate;
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60.0];

    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  @"该起床了...";
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"开始学习iOS开发了" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 取消某个本地推送通知
- (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;  
            }  
        }  
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
//        [self.mainTbView.footer noticeNoMoreData];
        self.mainTbView.footer = nil;
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
//        [self scrollViewToIndex];
        
    }
    [self getNetData];
}

-(void)getNetData
{
    if (pageId == 1) {
        [self.mainMuArray removeAllObjects];
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",@(pageId),@(COUNT)];
    NSString *postStr = [NSString stringWithFormat:@"%@%@/%@/%@%@",kMainHeader,self.albumID,orderStr,urlStr,kDevice];
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@&id=%@",xContentList,self.albumID];

    
    __weak typeof(self) bSelf = self;
    
    [AFService getMethod:postStr andDict:nil completion:^(NSDictionary *results,NSError *error){
        
        totalTracks = [[[results objectForKey:@"album"] objectForKey:@"tracks"] integerValue];
        
        totalPage = [[[results objectForKey:@"tracks"] objectForKey:@"maxPageId"] integerValue];
        
        NSArray *arr = [[results objectForKey:@"tracks"] objectForKey:@"list"];
        
//        NSArray *arr = (NSArray *) results ;

        for (int i = 0; i < arr.count; i++) {
            TrackModel *track = [[TrackModel alloc]initWithDict:arr[i]];
            track.coverLarge = bSelf.albumImage;
            track.downStatus = @"on";
            [bSelf.mainMuArray addObject:track];
        }
        
        [bSelf.mainTbView reloadData];
        [self.mainTbView.header endRefreshing];
        [bSelf.mainTbView.footer endRefreshing];
        
        if (bSelf.mainMuArray.count != 0) {
            if (bSelf.mainMuArray.count > [CommUtils getPlayIndex]) {
//                [bSelf scrollViewToIndex];
            }else{
                [self loadMoreData];
            }
        }
        
        if ([CommUtils checkNetworkStatus] == ReachableViaWiFi) {
            [self.needDownMuArray removeAllObjects];
            
            for (int i = 0; i<self.mainMuArray.count; i++) {
                TrackModel *track = self.mainMuArray[i];
                track.orderStr = [NSString stringWithFormat:@"%d",i];
                if (![track.downStatus isEqualToString:@"done"]) {
                    [self.needDownMuArray addObject:track];
                }
            }
            if (downStatus !=  DownloadStateStart) {
                [self automaticDownloads];
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
    static NSString *MainCellIdentifier = @"MainCell";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellIdentifier];
    if (!cell) {
        cell = (MainCell *)CREAT_XIB(@"MainCell");
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    TrackModel *track = self.mainMuArray[indexPath.row];
    TrackModel *newTrack = [[MainList sharedManager] updateModel:track];
    if (newTrack) {
        track.downStatus = newTrack.downStatus;
    }
    cell.titleLabel.text = track.title;
    cell.downLabel.text = @"在线";
    cell.downLabel.textColor = kCommenColor;
    
    if (indexPath.row == [CommUtils getPlayIndex]){
        cell.titleLabel.textColor = kCommenColor;

        NSMutableString *muStr = [NSMutableString stringWithString:track.title];
        if (muStr.length > 20) {
            cell.titleLabel.moveSpeech = -50.0f;
        }else{
            cell.titleLabel.moveSpeech = 0;
        }
    }else{
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.titleLabel.moveSpeech = 0;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TrackModel *track = self.mainMuArray[indexPath.row];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:HSFileFullpath(track.playUrl64)]){
//        [self pushPlayVC:indexPath.row];
//    }else
    if ([CommUtils checkNetworkStatus] != ReachableViaWiFi) {
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
    playVC.albumTitle = self.albumTitle;
    
    if (self.mainMuArray.count != 0) {
        [playVC pushArr:self.mainMuArray andIndex:indexPlay];
    }
//    [self.navigationController presentViewController:playVC animated:YES completion:nil];
    [self.navigationController pushViewController:playVC animated:YES];
}



#pragma mark 开启任务下载资源
- (void)download:(NSString *)url progressLabel:(UILabel *)progressLabel progressView:(UIProgressView *)progressView button:(UIButton *)button
{
    [[HSDownloadManager sharedInstance] download:url progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateDownView:progress];
        });
    } state:^(DownloadState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            downStatus = state;
            
            if (state == DownloadStateCompleted) {
                TrackModel *track = self.needDownMuArray[0];
                track.downStatus = @"done";
                [[MainList sharedManager] saveContent:track];
                
                [self.mainTbView reloadData];
                
                [self.needDownMuArray removeObjectAtIndex:0];
                [self automaticDownloads];
            }
        });
    }];
}

#pragma mark 按钮状态
- (NSString *)getTitleWithDownloadState:(DownloadState)state
{
    switch (state) {
        case DownloadStateStart:
            return @"暂停";
        case DownloadStateSuspended:
        case DownloadStateFailed:
            return @"开始";
        case DownloadStateCompleted:
            return @"完成";
        default:
            break;
    }
}

-(void)automaticDownloads
{
//    if (self.needDownMuArray.count != 0 && [CommUtils checkNetworkStatus] == ReachableViaWiFi) {
//        TrackModel *track = self.needDownMuArray[0];
//        track.downStatus = @"doing";
//        [[MainList sharedManager] saveContent:track];
//        
//        NSIndexPath *indexP = [NSIndexPath indexPathForRow:track.orderStr.integerValue inSection:0];
//        MainCell *newCell = [self.mainTbView cellForRowAtIndexPath:indexP];
//        
//        [self download:track.playUrl64 progressLabel:newCell.downLabel progressView:nil button:nil];
//    }
}

#pragma mark - 下载进度

-(void)updateDownView:(CGFloat)progress
{
    TrackModel *track = self.needDownMuArray[0];
    NSInteger integer = progress * 100;
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:track.orderStr.integerValue inSection:0];
    MainCell *newCell = [self.mainTbView cellForRowAtIndexPath:indexP];
    newCell.downLabel.text =  [NSString stringWithFormat:@"%ld%%",integer];
}

@end
