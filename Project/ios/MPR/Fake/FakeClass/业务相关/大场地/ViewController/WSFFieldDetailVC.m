//
//  WSFFieldDetailVC.m
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldDetailVC.h"
#import "WSFNavigationView.h"
#import "WSFSpaceMapVC.h"
#import "GoodsListCView.h"
#import "WSFDetailsSetMealView.h"
#import "NSMutableAttributedString+WSF_AdjustString.h"
#import "WSFFieldDetailApi.h"
#import "MapPositionManager.h"
#import "WSFFieldDetailM.h"
#import "SpacePhotoModel.h"
#import "WSFFieldMealView.h"
#import "WSFFieldSelectedVC.h"
#import "WSFFieldMealVM.h"
#import "WSFShareView.h"
#import "WSFPhotoBrowserVC.h"

@interface WSFFieldDetailVC ()<SDCycleScrollViewDelegate, WSFNavigationViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UILabel *currentNum;
@property (nonatomic, strong) WSFNavigationView *customNavgationView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) GoodsListCView *goodListView;
@property (nonatomic, strong) WSFFieldMealView *detailMealView;
@property (nonatomic, strong) UILabel *spaceNameLabel;
@property (nonatomic, strong) UILabel *spacePriceLabel;
@property (nonatomic, strong) UILabel *personNunLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *explainLabel;
//@property (nonatomic, strong) UIButton *reverceBtn;//预定按钮
@property (nonatomic, strong) WSFFieldDetailM *detailModel;
@property (nonatomic, strong) UIView *noNetView;

@property (nonatomic, strong) NSMutableArray *photosUrlArray;// 轮播图数组<URLString *>
@end

@implementation WSFFieldDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor colorWithHexString:@"1a1a1a" alpha:0.4];
        statusBar.backgroundColor = [UIColor clearColor];
    }
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self netRequest];
}

- (void)netRequest {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [[MapPositionManager sharedLocationManager] getCoorinate:^(CLLocationCoordinate2D coordinate) {
    WSFFieldDetailApi *detailApi = [[WSFFieldDetailApi alloc] initWithTheRoomId:self.roomId coor:coordinate];
    [detailApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
      NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      NSDictionary *dic = messageDic[@"Data"];
      self.detailModel = [WSFFieldDetailM modelFromDict:dic];
      
      [self setContentView];
      
      //轮播图片
      self.photosUrlArray = [NSMutableArray array];
      for (SpacePhotoModel *photoModel in self.detailModel.photosArray) {
        [self.photosUrlArray addObject:[NSString replaceString:photoModel.photoFilePath]];
      }
      self.cycleScrollView.imageURLStringsGroup = self.photosUrlArray;
      if (self.cycleScrollView.imageURLStringsGroup.count > 0) {
        self.currentNum.text = [NSString stringWithFormat:@"1/%lu", (unsigned long)self.cycleScrollView.imageURLStringsGroup.count];
      }else {
        self.currentNum.text = [NSString stringWithFormat:@"0/%lu", (unsigned long)self.cycleScrollView.imageURLStringsGroup.count];
      }
      //空间名称
      self.spaceNameLabel.text = self.detailModel.roomName;
      //空间价格
      self.spacePriceLabel.attributedText = [NSMutableAttributedString wsf_adjustOriginalString:[NSString stringWithFormat:@"¥%ld/场 起", (long)self.detailModel.price] frontStringColor:HEX_COLOR_0x2B84C6 frontStringFont:17 behindString:@"起"];
      ;
      //空间容纳人数
      self.personNunLabel.text = [NSString stringWithFormat:@"%ld人%@  |  %ld平米  |", (long)self.detailModel.capacity, self.detailModel.roomType ,(long)self.detailModel.areaSize];
      //空间距离
      NSString *meterStr = [NSString distanceSizeFormatWithOriginMeter:self.detailModel.theMeter];
      self.distanceLabel.text = [NSString stringWithFormat:@"距离您%@", meterStr];
      //物品的展示
      self.goodListView.SpaceGoodsArray = self.detailModel.devicesArray;
      if (self.goodListView.SpaceGoodsArray.count > 0) {
        CGFloat goodsListViewRow = (self.goodListView.SpaceGoodsArray.count-1)/3+1;
        self.goodListView.frame = CGRectMake(0, 306.67, SCREEN_WIDTH, (20+35*goodsListViewRow+10*(goodsListViewRow-1)));
        
      }else {
        self.goodListView.frame = CGRectMake(0, 306.67, SCREEN_WIDTH, 0);
      }
      //空间简介
      self.explainLabel.text = self.detailModel.spaceDescription;
      if([self.view.subviews containsObject:_noNetView])[_noNetView removeFromSuperview];
      
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      
      // 网络请求是否超时
      BOOL isRequestOutTime = [request.error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"];
      
      if (kNetworkNotReachability ||isRequestOutTime) {
        [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
      }
      
      @weakify(self);
      BOOL showBool = (kNetworkNotReachability || isRequestOutTime);
      _noNetView = [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
        @strongify(self);
        [self netRequest];
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
      
    }];
  } address:nil error:nil];
}

- (void)setContentView {
    //下层的scroolView
    self.baseScrollView = [[UIScrollView alloc] init];
    self.baseScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.baseScrollView.delegate = self;
    self.baseScrollView.scrollEnabled = YES;
    self.baseScrollView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
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
    self.spacePriceLabel.font = SYSTEMFONT_13;
    self.spacePriceLabel.textColor = HEX_COLOR_0xCCCCCC;
    self.spacePriceLabel.attributedText = [NSMutableAttributedString wsf_adjustOriginalString:@"¥100.0/场 起" frontStringColor:HEX_COLOR_0x2B84C6 frontStringFont:17 behindString:@"起"];
    [spaceMessageView addSubview:self.spacePriceLabel];
    [self.spacePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(spaceMessageView.mas_right).offset(-10);
        make.top.mas_equalTo(spaceMessageView.mas_top).offset(10);
    }];
    // 空间起购价
    UILabel *minimumLabel = [[UILabel alloc] init];
//    minimumLabel.text = self.spaceDetailMessageModel.minimum > 0 ? [NSString stringWithFormat:@"%ld元起订", (long)self.spaceDetailMessageModel.minimum] : @"";
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
    self.personNunLabel.text = @"10人会议室  |  120平米  |";
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
    [spaceLocationButton setTitle:self.detailModel.address  forState:UIControlStateNormal];
    [spaceLocationButton setTitleColor:HEX_COLOR_0x2B84C6 forState:UIControlStateNormal];
    [spaceLocationButton.titleLabel setFont:SYSTEMFONT_13];
    [spaceLocationButton setImage:[UIImage imageNamed:@"dibiao_small_blue"] forState:UIControlStateNormal];
    
    [spaceLocationButton addTouchUpInsideBlock:^(UIButton *button) {
        
        WSFSpaceMapVC *spaceMapVC = [[WSFSpaceMapVC alloc] init];
        spaceMapVC.currentAddress = self.detailModel.address;
        CLLocationCoordinate2D coor;
        coor.longitude = self.detailModel.lng;
        coor.latitude = self.detailModel.lat;
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
    
    WSFFieldMealVM *detailVM = [[WSFFieldMealVM alloc] initWithsetMealModelArray:self.detailModel.setMealModelArray];
    
    self.detailMealView = [[WSFFieldMealView alloc] initWithDetailsSetMealViewModel:detailVM];
    self.detailMealView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:self.detailMealView];
    [self.detailMealView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.mas_equalTo(self.detailMealView.mas_bottom).offset(10);
        make.top.mas_equalTo(explainView.mas_bottom).offset(10).priority(250);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    
    //content
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(telephoneBtn.mas_bottom).offset(15);
    }];
    
    //预定按钮
//    self.reverceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.reverceBtn setFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
//    [self.reverceBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#2b84c6"]] forState:UIControlStateNormal];
//    [self.reverceBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#cccccc"]] forState:UIControlStateSelected];
//    [self.reverceBtn setTitle:@"选择场次" forState:UIControlStateNormal];
//    [self.reverceBtn addTarget:self action:@selector(reverceAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.reverceBtn];
    
    // 套餐View
    if (self.detailModel.setMealModelArray.count == 0) {
        [self.detailMealView removeFromSuperview];
        [self.view layoutIfNeeded];
    }
  
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
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
        self.customNavgationView.titleName = self.spaceNameLabel.text;
        self.customNavgationView.titleColor = [UIColor whiteColor];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.currentNum.text = [NSString stringWithFormat:@"%ld/%u", (long)index+1, (unsigned)cycleScrollView.imageURLStringsGroup.count];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    WSFPhotoBrowserVC *photoBrowserVC = [[WSFPhotoBrowserVC alloc] init];
    [self presentViewController:photoBrowserVC animated:NO completion:nil];
    [photoBrowserVC setupPhotoURLList:self.photosUrlArray selectedIndex:index];
}

//- (void)reverceAction {
//    WSFFieldSelectedVC *selectedVC = [[WSFFieldSelectedVC alloc]init];
//    selectedVC.roomId = self.roomId;
//    selectedVC.detailModel = self.detailModel;
//    [self.navigationController pushViewController:selectedVC animated:NO];
//}

#pragma mark - WSFNavigationdelegate
- (void)navigationBarButtonLeftAction {
    [self doBackAction];
}

//- (void)navigationBarButtonRightAction {
//    WSFShareMessageModel *model = [[WSFShareMessageModel alloc] init];
//    model.shareTitle = @"我在这里发现了一个好地方，你也看看吧~";
//    model.shareDescr = @"面基、团建、见客户，妈妈再也不用担心我找不到好去处了！";
//    model.shareURL = self.detailModel.roomShareUrl;
//    model.shareThumImage = [UIImage imageNamed:@"logo"];
//    model.shareReminder = @"分享可获得专属红包";
//    model.shareViewType = WSFShareViewType_Normal;
//    [WSFShareView showWithShareMessageModel:model];
//}

/**  打电话-- 联系商家 */
- (void)callPhoneAction {
    [HSMathod callPhoneWithNumber:self.detailModel.tel];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
