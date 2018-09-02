//
//  SpaceDetailViewController.m
//  WinShare
//
//  Created by QIjikj on 2017/5/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceDetailViewController.h"
#import "GoodsListCView.h"
#import "ViewOfBaiduMap.h"
#import "SpaceDataVM.h"
#import "SpaceDetailMessageModel.h"
#import "SpacePhotoModel.h"
#import "WSFNavigationView.h"
#import "WSFShareView.h"
#import "HSFDotMessageView.h"
#import "WSFSetMealModel.h"
#import "WSFSpaceMapVC.h"
#import "WSFSpaceListMapManager.h"

#import "WSFDetailsSetMealView.h"
#import "WSFDetailsSetMealViewModel.h"
#import "WSFPhotoBrowserVC.h"

@interface SpaceDetailViewController ()<SDCycleScrollViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate, BMKLocationServiceDelegate, WSFNavigationViewDelegate>
@property (nonatomic, strong) UILabel *currentNum;
@property (nonatomic, strong) UIScrollView *baseScrollView;

@property (nonatomic, strong) WSFNavigationView *customNavgationView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UILabel *spaceNameLabel;
@property (nonatomic, strong) UILabel *spacePriceLabel;
@property (nonatomic, strong) UILabel *personNunLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *explainLabel;
@property (nonatomic, strong) ViewOfBaiduMap *spaceLocationView;
@property (nonatomic, strong) GoodsListCView *goodListView;
@property (nonatomic, strong) UIView *setMealDisplayView;

@property (nonatomic, strong) WSFDetailsSetMealView *detailSetMealView;

//@property (nonatomic, strong) UIButton *reverceBtn;//预定按钮

@property (nonatomic, strong) SpaceDetailMessageModel *spaceDetailMessageModel;

@property (nonatomic, strong) BMKLocationService *locService;//定位服务



@property (nonatomic, strong) NSMutableArray *photosUrlArray;//空间轮播图<URLString *>

@end

@implementation SpaceDetailViewController

#pragma mark - VC的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#cccccc" alpha:1];
    
    /*
    //判断定位功能是否可用
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
        
        //定位功能可用，定位
        [self.locService startUserLocationService];
        
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted){
        
        //定位功能不可用，提示
        [self presentViewController:self.alertVC animated:NO completion:nil];
    }
     */
    
    [self getSpaceDetailDataFromWebWithlng:self.screenCoor.longitude lat:self.screenCoor.latitude];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor colorWithHexString:@"1a1a1a" alpha:0.4];
        statusBar.backgroundColor = [UIColor clearColor];
    }
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
    self.navigationController.navigationBarHidden = NO;
    _spaceLocationView = nil;
}

#pragma mark - 网络请求
- (void)getSpaceDetailDataFromWebWithlng:(double)lng lat:(double)lat
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [SpaceDataVM getSpaceDetailDataV2WithSpaceId:self.SpaceId lng:lng lat:lat success:^(NSDictionary *spaceDetailDictionary) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSLog(@"获取空间详情数据成功：%@", spaceDetailDictionary);
        
        self.spaceDetailMessageModel = [SpaceDetailMessageModel modelFromDict:spaceDetailDictionary];
        
        [self setupViewContent];
        
        //轮播图片
        self.photosUrlArray = [NSMutableArray array];
        for (SpacePhotoModel *photoModel in self.spaceDetailMessageModel.photosArray) {
            [self.photosUrlArray addObject:[NSString replaceString:photoModel.photoFilePath]];
        }
        self.cycleScrollView.imageURLStringsGroup = self.photosUrlArray;
        self.currentNum.text = [NSString stringWithFormat:@"1/%lu", (unsigned long)self.cycleScrollView.imageURLStringsGroup.count];
        //空间名称
        self.spaceNameLabel.text = self.spaceDetailMessageModel.roomName;
        //空间价格
        self.spacePriceLabel.text = [NSString stringWithFormat:@"¥%ld/h", (long)self.spaceDetailMessageModel.price];
        //空间容纳人数
        self.personNunLabel.text = [NSString stringWithFormat:@"%ld人%@", (long)self.spaceDetailMessageModel.capacity, self.spaceDetailMessageModel.roomType];
        //空间距离
        NSString *meterStr = [NSString distanceSizeFormatWithOriginMeter:self.spaceDetailMessageModel.theMeter];
        if (self.inScreen) {
            self.distanceLabel.text = [NSString stringWithFormat:@"距离%@%@", [NSString wsf_stringbyString:self.screenAddressStr length:5 point:YES], meterStr];
        }else {
            self.distanceLabel.text = [NSString stringWithFormat:@"距离您%@", meterStr];
        }
        //物品的展示
        self.goodListView.SpaceGoodsArray = self.spaceDetailMessageModel.devicesArray;
        if (self.goodListView.SpaceGoodsArray.count > 0) {
            CGFloat goodsListViewRow = (self.goodListView.SpaceGoodsArray.count-1)/3+1;
            self.goodListView.frame = CGRectMake(0, 306.67, SCREEN_WIDTH, (20+35*goodsListViewRow+10*(goodsListViewRow-1)));
            
        }else {
            self.goodListView.frame = CGRectMake(0, 306.67, SCREEN_WIDTH, 0);
        }
        //空间简介
        self.explainLabel.text = self.spaceDetailMessageModel.spaceDescription;
        //空间的地理位置展示
        CLLocationCoordinate2D coor;
        coor.longitude = self.spaceDetailMessageModel.lng;
        coor.latitude = self.spaceDetailMessageModel.lat;
        _spaceLocationView.coor = coor;
        _spaceLocationView.locationAddress = _spaceDetailMessageModel.address;
//        //预定按钮
//        if (self.spaceDetailMessageModel.waitOnline) {
//            [self.reverceBtn setSelected:YES];
//        }
        // 套餐View
        if (self.spaceDetailMessageModel.setMealModelArray.count == 0) {
            [self.detailSetMealView removeFromSuperview];
            [self.view layoutIfNeeded];
        }
        
    } failed:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        [self.view viewDisplayNotFoundViewWithNetworkLoss:(kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getSpaceDetailDataFromWebWithlng:lng lat:lat];
        }];
        
        //回退按钮
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      if (isPhoneX) {
        leftBtn.frame = CGRectMake(0, 40, 30, 30);
      }else {
        leftBtn.frame = CGRectMake(0, 20, 30, 30);
      }
        leftBtn.backgroundColor = [UIColor colorWithHexString:@"#2483C3" alpha:0.5];
        leftBtn.layer.cornerRadius = 15;
        [leftBtn setImage:[UIImage imageNamed:@"Arrow-white"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(doBackAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:leftBtn];
        
        NSLog(@"获取空间详情失败:%@", error);
    }];
}

#pragma mark - 界面搭建

- (void)setupViewContent
{
    //下层的scroolView
    self.baseScrollView = [[UIScrollView alloc] init];
    self.baseScrollView.delegate = self;
    self.baseScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.baseScrollView.scrollEnabled = YES;
    self.baseScrollView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    UIGestureRecognizer *gestur = [[UIGestureRecognizer alloc]init];
    gestur.delegate=self;
    [self.baseScrollView addGestureRecognizer:gestur];
    [self.view addSubview: self.baseScrollView];
    //contentView
    UIView *contentView = [[UIView alloc]init];
    [self.baseScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.baseScrollView);
        make.width.equalTo(self.baseScrollView);
    }];
    // 导航栏View
    self.customNavgationView = [[WSFNavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.customNavgationView.bgImageView.backgroundColor = [UIColor colorWithHexString:@"#3086C5"];
    self.customNavgationView.titleColor = [UIColor whiteColor];
    self.customNavgationView.leftBackgroundImage = @"Arrow-white";
//    self.customNavgationView.rightBackgroundImage = @"icon_share";
  self.customNavgationView.rightBackgroundImage = nil;
    self.customNavgationView.delegate = self;
    [self.view addSubview:self.customNavgationView];
    //轮播图片
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) delegate:self placeholderImage:[UIImage imageNamed:@"logo_big_bg"]];
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    self.cycleScrollView.imageURLStringsGroup = @[];
    self.cycleScrollView.autoScrollTimeInterval = 4.0;
    [contentView addSubview:self.cycleScrollView];
    //当前显示的图片页数
    self.currentNum = [[UILabel alloc] init];
    self.currentNum.font = [UIFont systemFontOfSize:14];
    self.currentNum.textColor = [UIColor colorWithHexString:@"ffffff" alpha:1];
    self.currentNum.text = [NSString stringWithFormat:@"1/%lu", (unsigned long)self.cycleScrollView.imageURLStringsGroup.count];
    [self.cycleScrollView addSubview:self.currentNum];
    [self.currentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cycleScrollView.mas_right).offset(-10);
        make.bottom.mas_equalTo(-10);
    }];
    
    //........
    UIView *spaceMessageView = [[UIView alloc] init];
    [spaceMessageView setBackgroundColor:[UIColor whiteColor]];
    [contentView addSubview:spaceMessageView];
    [spaceMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(0);
        make.width.equalTo(self.baseScrollView);
    }];
    
    //空间名称、空间类型
    self.spaceNameLabel = [[UILabel alloc] init];
    self.spaceNameLabel.font = SYSTEMFONT_17;
    self.spaceNameLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.spaceNameLabel.text = @"咖啡馆";
    [spaceMessageView addSubview:self.spaceNameLabel];
    [self.spaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(spaceMessageView.mas_top).offset(10);
    }];
    //空间价格
    self.spacePriceLabel = [[UILabel alloc] init];
    self.spacePriceLabel.font = SYSTEMFONT_17;
    self.spacePriceLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.spacePriceLabel.text = @"¥200.0/h";
    [spaceMessageView addSubview:self.spacePriceLabel];
    [self.spacePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(spaceMessageView.mas_right).offset(-10);
        make.top.mas_equalTo(spaceMessageView.mas_top).offset(10);
    }];
    // 空间起购价
    UILabel *minimumLabel = [[UILabel alloc] init];
    minimumLabel.text = self.spaceDetailMessageModel.minimum > 0 ? [NSString stringWithFormat:@"%ld元起订", (long)self.spaceDetailMessageModel.minimum] : @"";
    minimumLabel.font = SYSTEMFONT_13;
    minimumLabel.textColor = HEX_COLOR_0x808080;
    [spaceMessageView addSubview:minimumLabel];
    [minimumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.spacePriceLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(spaceMessageView.mas_right).offset(-10);
    }];
    //空间容纳人数
    self.personNunLabel = [[UILabel alloc] init];
    self.personNunLabel.font = SYSTEMFONT_13;
    self.personNunLabel.textColor = HEX_COLOR_0x808080;
    self.personNunLabel.text = @"10人会议室";
    [spaceMessageView addSubview:self.personNunLabel];
    [self.personNunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.spaceNameLabel.mas_bottom).offset(10);
    }];
    //一条隔离线
    UIView *gapLineView1 = [[UIView alloc] init];
    gapLineView1.backgroundColor = HEX_COLOR_0xCCCCCC;
    [spaceMessageView addSubview:gapLineView1];
    [gapLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.personNunLabel.mas_right).offset(9);
        make.top.mas_equalTo(self.personNunLabel.mas_top).offset(2);
        make.size.mas_equalTo(CGSizeMake(0.5, 12));
    }];
    //空间距离
    self.distanceLabel = [[UILabel alloc] init];
    self.distanceLabel.font = SYSTEMFONT_13;
    self.distanceLabel.textColor = HEX_COLOR_0x808080;
    self.distanceLabel.text = @"距离您500m";
    [spaceMessageView addSubview:self.distanceLabel];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gapLineView1.mas_right).offset(10);
        make.top.mas_equalTo(self.personNunLabel.mas_top);
        make.right.lessThanOrEqualTo(minimumLabel.mas_left).offset(-5);
    }];
    // 空间的地理位置
    HSBlockButton *spaceLocationButton = [HSBlockButton buttonWithType:UIButtonTypeCustom];
    spaceLocationButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    spaceLocationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    spaceLocationButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    spaceLocationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [spaceLocationButton setTitle:self.spaceDetailMessageModel.address forState:UIControlStateNormal];
    [spaceLocationButton setTitleColor:HEX_COLOR_0x2B84C6 forState:UIControlStateNormal];
    [spaceLocationButton.titleLabel setFont:SYSTEMFONT_13];
    [spaceLocationButton setImage:[UIImage imageNamed:@"dibiao_small_blue"] forState:UIControlStateNormal];
    
    [spaceLocationButton addTouchUpInsideBlock:^(UIButton *button) {
        
        WSFSpaceMapVC *spaceMapVC = [[WSFSpaceMapVC alloc] init];
        spaceMapVC.currentAddress = self.spaceDetailMessageModel.address;
        CLLocationCoordinate2D coor;
        coor.longitude = self.spaceDetailMessageModel.lng;
        coor.latitude = self.spaceDetailMessageModel.lat;
        spaceMapVC.currentCoor = coor;
        [self.navigationController pushViewController:spaceMapVC animated:NO];
    }];
    [spaceMessageView addSubview:spaceLocationButton];
    [spaceLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.personNunLabel.mas_bottom).offset(8);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(spaceMessageView.mas_bottom).offset(-10);
    }];

    //物品展示
    UICollectionViewFlowLayout *goodsLayout = [[UICollectionViewFlowLayout alloc] init];
    goodsLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.goodListView = [[GoodsListCView alloc] initWithFrame:CGRectMake(0, 306.67, SCREEN_WIDTH, 100) collectionViewLayout:goodsLayout];
    self.goodListView.scrollEnabled = NO;
    self.goodListView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:self.goodListView];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodListView.mas_top).mas_equalTo(0);
        make.left.mas_equalTo(self.goodListView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.goodListView.mas_bottom).mas_equalTo(0);
        make.left.mas_equalTo(self.goodListView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];

    //.....
    UIView *explainView = [[UIView alloc] init];
    explainView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:explainView];
    [explainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodListView.mas_bottom).offset(0);
        make.width.equalTo(self.baseScrollView);
    }];
    //空间简介
    self.explainLabel = [[UILabel alloc] init];
    self.explainLabel.font = [UIFont systemFontOfSize:14];
    self.explainLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.explainLabel.numberOfLines = 0;
    self.explainLabel.text = @"我们提供免费的咖啡10杯。会议室采用专业隔音墙，配备专业的会议室设备，非常期待您的预订。";
    [contentView addSubview:self.explainLabel];
    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(explainView.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-20);
        make.bottom.mas_equalTo(explainView.mas_bottom).offset(-10);
    }];
    
    WSFDetailsSetMealViewModel *detailSetMealVM = [[WSFDetailsSetMealViewModel alloc] initWithSetMealModelArray:self.spaceDetailMessageModel.setMealModelArray];
    
    self.detailSetMealView = [[WSFDetailsSetMealView alloc] initWithDetailsSetMealViewModel: detailSetMealVM];
    self.detailSetMealView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:self.detailSetMealView];
    [self.detailSetMealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(explainView.mas_bottom).offset(10);
        make.left.mas_equalTo(contentView.mas_left).offset(0);
        make.right.mas_equalTo(contentView.mas_right).offset(0);
    }];

    //.....
    //拨打电话
    UIButton *telephoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    telephoneBtn.backgroundColor = [UIColor whiteColor];
    [telephoneBtn setTitle:@"联系电话" forState:UIControlStateNormal];
    [telephoneBtn setTitleColor:[UIColor colorWithHexString:@"1a1a1a"] forState:UIControlStateNormal];
    [telephoneBtn setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    telephoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    telephoneBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    telephoneBtn.imageEdgeInsets = UIEdgeInsetsMake(15, SCREEN_WIDTH-30, 0, 0);
    telephoneBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -10, 0, 0);
    telephoneBtn.eventTimeInterval = 1;
    [telephoneBtn addTarget:self action:@selector(callPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:telephoneBtn];
    [telephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.detailSetMealView.mas_bottom).offset(10);
        make.top.mas_equalTo(explainView.mas_bottom).offset(10).priority(250);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];

    //content
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(telephoneBtn.mas_bottom).offset(15);
    }];
    
    /* V2.4.0版本的调整，不需要该按钮
    //回退按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 30, 30);
    leftBtn.backgroundColor = [UIColor colorWithHexString:@"#2483C3" alpha:0.5];
    leftBtn.layer.cornerRadius = 15;
    [leftBtn setImage:[UIImage imageNamed:@"Arrow-white"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(doBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
     */
    //预定按钮
//    self.reverceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.reverceBtn setFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
//    [self.reverceBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#2b84c6"]] forState:UIControlStateNormal];
//    [self.reverceBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#cccccc"]] forState:UIControlStateSelected];
//    [self.reverceBtn setTitle:@"预定" forState:UIControlStateNormal];
//    [self.reverceBtn setTitle:@"即将上线" forState:UIControlStateSelected];
//    [self.reverceBtn addTarget:self action:@selector(reverceAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.reverceBtn];
    
}

#pragma mark - 图片轮播的协议方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    WSFPhotoBrowserVC *photoBrowserVC = [[WSFPhotoBrowserVC alloc] init];
    [self presentViewController:photoBrowserVC animated:NO completion:nil];
    [photoBrowserVC setupPhotoURLList:self.photosUrlArray selectedIndex:index];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.currentNum.text = [NSString stringWithFormat:@"%ld/%u", index+1, (unsigned)cycleScrollView.imageURLStringsGroup.count];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = self.baseScrollView.contentOffset;
    if (point.y < 0) {
        //不可以向下滑动
        self.baseScrollView.contentOffset = CGPointMake(0, 0);
    }

    if (scrollView.contentOffset.y <= (220-64)) {
        self.customNavgationView.bgImageView.alpha = scrollView.contentOffset.y / (220-64);
        self.customNavgationView.leftBackgroundImage = @"Arrow-white";
//        self.customNavgationView.rightBackgroundImage = @"icon_share";
        self.customNavgationView.titleName = @"";
        self.customNavgationView.titleColor = [UIColor whiteColor];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }else{
        self.customNavgationView.bgImageView.alpha = 1;
        self.customNavgationView.leftBackgroundImage = @"Arrow-white";
//        self.customNavgationView.rightBackgroundImage = @"icon_share";
        self.customNavgationView.titleName = self.spaceDetailMessageModel.roomName;
        self.customNavgationView.titleColor = [UIColor whiteColor];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

#pragma mark - 懒加载
- (BMKLocationService *)locService
{
    if (!_locService) {
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
    }
    return _locService;
}

#pragma mark - 辅助方法、界面按钮交互
//// 获取距离大小
//- (NSString *)distanceSizeFormatWithOriginMeter:(NSInteger)originMeter
//{
//    NSString *sizeUnitString;
//    float size = originMeter;
//    if(size < 1000){
//
//        sizeUnitString = [NSString stringWithFormat:@"%.1fm", size];
//
//    }else{
//
//        size /= 1000;
//        sizeUnitString = [NSString stringWithFormat:@"%.1fkm", size];
//    }
//
//    return sizeUnitString;
//}

/**  打电话-- 联系商家 */
- (void)callPhoneAction
{
    [HSMathod callPhoneWithNumber:self.spaceDetailMessageModel.tel];
}

///** 点击预订按钮 */
//- (void)reverceAction:(UIButton *)btn
//{
//    if (btn.isSelected) {
//        return ;
//    }
//    BookSpaceVC *bookVC = [[BookSpaceVC alloc]init];
//    bookVC.price = self.spaceDetailMessageModel.price;
//    bookVC.spaceId = self.SpaceId;
//    [self.navigationController pushViewController:bookVC animated:NO];
//}

#pragma mark - BMKLocationServiceDelegate-用户位置更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //设置地图中心为用户经纬度
    NSLog(@"定位的经度:%f,定位的纬度:%f",_locService.userLocation.location.coordinate.longitude, _locService.userLocation.location.coordinate.latitude);
    
    [self getSpaceDetailDataFromWebWithlng:_locService.userLocation.location.coordinate.longitude lat:_locService.userLocation.location.coordinate.latitude];
    
    [_locService stopUserLocationService];
}

#pragma mark - 手势的协议方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //在这里判断是百度地图的view 既可以实现手势拖动 scrollview 的滚动关闭
    if ([gestureRecognizer.view isKindOfClass:[BMKMapView class]] ){
        
        self.baseScrollView.scrollEnabled = NO;
        return YES;
        
    }else{
        
        self.baseScrollView.scrollEnabled = YES;
        return NO;
    }
    
}

#pragma mark - WSFNavigationdelegate
- (void)navigationBarButtonLeftAction
{
    [self doBackAction];
}

//- (void)navigationBarButtonRightAction
//{
//    WSFShareMessageModel *model = [[WSFShareMessageModel alloc] init];
//    model.shareTitle = @"我在这里发现了一个好地方，你也看看吧~";
//    model.shareDescr = @"面基、团建、见客户，妈妈再也不用担心我找不到好去处了！";
//    model.shareURL = self.spaceDetailMessageModel.roomShareUrl;
//    model.shareThumImage = [UIImage imageNamed:@"logo"];
//    model.shareReminder = @"分享可获得专属红包";
//    model.shareViewType = WSFShareViewType_Normal;
//    [WSFShareView showWithShareMessageModel:model];
//
//}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
