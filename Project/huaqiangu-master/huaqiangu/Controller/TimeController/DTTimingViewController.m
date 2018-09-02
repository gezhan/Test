//
//  DTTimingViewController.m
//  duotin2.0
//
//  Created by Vienta on 14-10-17.
//  Copyright (c) 2014年 Duotin Network Technology Co.,LTD. All rights reserved.
//

#import "DTTimingViewController.h"
#import "DTTimingManager.h"
#import "PlayController.h"

@interface DTTimingViewController ()<BaiduMobAdViewDelegate,GADBannerViewDelegate>{
//    GADBannerView *adBannerView;
    BaiduMobAdView *sharedAdView;
    GADBannerView *adBannerView;
}
@end

@implementation DTTimingViewController
{
    NSMutableArray *_timingData;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -
#pragma mark - 百度广告bannar

-(void)addBaiDuAdView
{
    //使用嵌入干告的方法实例。
    if (!sharedAdView) {
        sharedAdView = [[BaiduMobAdView alloc] init]; //把在mssp.baidu.com上创建后获得的代码位id写到这里
        sharedAdView.backgroundColor = [UIColor clearColor];
        sharedAdView.AdUnitTag = ADUNITTAGBANNER;
        sharedAdView.AdType = BaiduMobAdViewTypeBanner;
        sharedAdView.frame = CGRectMake(0, mainscreenhight - 50, mainscreenwidth, 50);
        //        sharedAdView.frame = kAdViewPortraitRect;
        sharedAdView.delegate = self;
        [self.view addSubview:sharedAdView];
        [sharedAdView start];
    }
}

- (NSString *)publisherId {
    return PUBLISHERID; //@"your_own_app_id";
}

-(void) willDisplayAd:(BaiduMobAdView*) adview {
    NSLog(@"delegate: will display ad");
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
    
    [adBannerView loadRequest:request];
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    bannerView.hidden = NO;
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", error.localizedDescription);
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

-(void)dealloc
{
    [sharedAdView removeFromSuperview];
    sharedAdView.delegate = nil;
    sharedAdView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tbvTiming.backgroundColor = RGB(230, 227, 219);
    self.view.backgroundColor = RGB(230, 227, 219);
    
//    [self addBaiDuAdView];
    [self admobAD];
    
    self.navigationItem.rightBarButtonItem = [LMButton setNavright:@"反馈" andcolor:[UIColor whiteColor] andSelector:@selector(pushAppStore) andTarget:self];

    [self layoutUI];
    _timingData = [NSMutableArray arrayWithCapacity:0];
    [_timingData addObject:@{@"content": @"不开启",
                             @"state":@(TimingStateNone)}];
    [_timingData addObject:@{@"content": @"10分钟后",
                             @"state":@(TimingStateTenMins)}];
    [_timingData addObject:@{@"content": @"20分钟后",
                             @"state":@(TimingStateTwentyMins)}];
    [_timingData addObject:@{@"content": @"30分钟后",
                             @"state":@(TimingStateThirtyMins)}];
    [_timingData addObject:@{@"content": @"60分钟后",
                             @"state":@(TimingStateOneHour)}];
    [_timingData addObject:@{@"content": @"90分钟后",
                             @"state":@(TimingStateNinetyMins)}];
    [_timingData addObject:@{@"content": @"当前单曲播放完毕后",
                             @"state":@(TimingStateAfterCurrentFinish)}];
    
    [self.tbvTiming performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    

    self.navigationItem.leftBarButtonItem=[LMButton setNavleftComboButtonWithImg:@"back" andSelector:@selector(backMethod) andTarget:self];
    
//    [self addAdmobView];
}

#pragma mark -
#pragma mark - 添加admob广告

-(void)addAdmobView{
//    adBannerView = [[GADBannerView alloc]init];
//    adBannerView.frame = CGRectMake(0, mainscreenhight - 50 * VIEWWITH, 320 * VIEWWITH, 50 * VIEWWITH);
//    adBannerView.adUnitID = KadMobKey;
//    adBannerView.rootViewController = self;
//    [self.view addSubview:adBannerView];
//    
//    [adBannerView loadRequest:[GADRequest request]];    
}

-(void)backMethod
{
    LM_POP;
}


- (void)layoutUI
{
    self.tbvTiming.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = [CommUtils navTittle:@"定时关闭"];
}

#pragma mark -
#pragma UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_timingData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"timingCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UIImageView * lineImg = [CommUtils cuttingLineWithOriginx:10 andOriginY:43.5];
    [cell.contentView addSubview:lineImg];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSInteger idx = indexPath.row;
    NSDictionary *dict = [_timingData objectAtIndex:idx];
    cell.textLabel.text = [dict objectForKey:@"content"];
    if ([[dict objectForKey:@"state"] integerValue] == [DTTimingManager sharedDTTimingManager].timingState){
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectCell"]];
    } else {
        cell.accessoryView = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger selectIdx = indexPath.row;
    NSDictionary *selectDict = [_timingData objectAtIndex:selectIdx];
    NSNumber *timingState = [selectDict objectForKey:@"state"];
    if ([timingState integerValue] == TimingStateAfterCurrentFinish) {
        if([PlayController sharedPlayController].playTrack.title) {
            [[DTTimingManager sharedDTTimingManager] startTiming:TimingStateAfterCurrentFinish];
        } else {
            [UIAlertView showWithTitle:@"温馨提示" message:@"当前没有播放节目" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
        }
        
    } else {
        [[DTTimingManager sharedDTTimingManager] startTiming:[timingState integerValue]];
    }


    [self.tbvTiming performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
