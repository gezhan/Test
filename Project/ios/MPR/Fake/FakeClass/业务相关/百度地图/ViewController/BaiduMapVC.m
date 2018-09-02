//
//  BaiduMapVC.m
//  WinShare
//
//  Created by GZH on 2017/5/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "BaiduMapVC.h"
#import "SpaceListViewController.h"
#import "SpaceMessageModel.h"
#import "SpaceDetailViewController.h"
#import "PopViewOfBaidu.h"
#import "CustormPointAnnotation.h"
#import "SpaceDataVM.h"
#import "ScreenConditionsVC.h"
#import "MapViewManager.h"
#import "WSFMapSpsceListView.h"
#import "WSFSpaceListMapManager.h"
#import "BaiduHeader.h"
#import "MapPositionManager.h"
#import "TheLoginVC.h"
#import "WSFButton+HSF_Composition.h"
#import "WSFSpaceNoServiceView.h"
#define ZoomLEVEl 15.0

@interface BaiduMapVC ()<BMKLocationServiceDelegate,BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locService; //定位
@property (nonatomic, strong) PopViewOfBaidu *baiduView;
@property (nonatomic, strong) UIButton *mapPin;           //地图中心点
@property (nonatomic, strong) BMKAnnotationView *selectionView;  //被选中的点
@property (nonatomic, strong) NSMutableArray <SpaceMessageModel *> *spaceListModelArray;  //当前界面显示的数据

@property (nonatomic, strong) WSFSpaceNoServiceView *noServiceView;
//@property (nonatomic, strong) WSFButton *titleBtn; //城市选择按钮
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation BaiduMapVC

#pragma mark - 控制器生命周期
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _mapView.delegate = self;
    _locService.delegate = self;
    [self.view addSubview:[WSFSpaceListMapManager shareManager].reminderView];
}

- (void)dealloc {
    _mapView = nil;
    _locService = nil;
    _mapView.delegate = nil;
    _locService.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupNavigationContent];
    
    [self setContentView];
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WSFSpaceListMapManager getConditionsSpaceListDataWithSuccess:^(NSArray * _Nonnull spaceListArray) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        weakSelf.spaceListModelArray = [SpaceMessageModel getModelArrayFromModelArray:spaceListArray];
        [weakSelf addPointAnnotation];
    } failed:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    [WSFSpaceListMapManager shareManager].resetBlock = ^{
        [weakSelf positioningSelfLocationWith:YES];
    };
}

#pragma mark - 基础界面搭建
- (void)setupNavigationContent {
    self.navigationItem.title = @"小包厢";
//    //left按钮
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    leftBtn.frame = CGRectMake(0, 0, 44, 44);
//    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [leftBtn setImage:[UIImage imageNamed:@"me"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIView *leftBtnView = [[UIView alloc]initWithFrame:leftBtn.frame];
//    [leftBtnView addSubview:leftBtn];
//    UIBarButtonItem * leftBarbutton = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    
//    UIBarButtonItem *leftSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    leftSpaceBarButton.width = -10;
//
//    self.navigationItem.leftBarButtonItems = @[leftSpaceBarButton, leftBarbutton];
    
    //right按钮
    // 切换地图
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setImage:[UIImage imageNamed:@"liebiao"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem * rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView];
    
    // 占位
    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpaceBarButton.width = -10;
    
    // 筛选
    UIButton *selectingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectingBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    selectingBtn.frame = CGRectMake(0, 0, 44, 44);
    [selectingBtn setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    [selectingBtn addTarget:self action:@selector(clickRightButton2:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightBtnView2 = [[UIView alloc]initWithFrame:selectingBtn.frame];
    [rightBtnView2 addSubview:selectingBtn];
    UIBarButtonItem * rightBarbutton2 = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView2];

    self.navigationItem.rightBarButtonItems = @[rightSpaceBarButton, rightBarbutton, rightSpaceBarButton, rightBarbutton2];
    
    //标题View
//    self.titleBtn = [WSFButton buttonWithType:UIButtonTypeCustom];
//    self.titleBtn.frame = CGRectMake(0, 0, 44, 44);
//    [self.titleBtn setImage:[UIImage imageNamed:@"xiangxia_samll"] forState:UIControlStateNormal];
//    [self.titleBtn setTitle:@"杭州市" forState:UIControlStateNormal];
//    [self.titleBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    [self.titleBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
//    [self.titleBtn hsf_layoutButtonWithEdgeInsetsStyle:WSFButtonEdgeInsetsType_ImageRight imageTitleSpace:2];
//    [self.titleBtn addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
//
//    self.navigationItem.titleView = self.titleBtn;
    
}

/** 点击切回到空间列表界面 */
- (void)clickRightButton:(UIButton *)btn {
    if(_popLastBlock)_popLastBlock();
    [self.navigationController popViewControllerAnimated:NO];
}

/** 点击进入条件筛选界面 */
- (void)clickRightButton2:(UIButton *)btn {
    __weak typeof(self) weakSelf = self;
    [[WSFSpaceListMapManager shareManager] pushToScreenVCFormVC:self completeBlock:^{
        [WSFSpaceListMapManager getConditionsSpaceListDataWithSuccess:^(NSArray * _Nonnull spaceListArray) {
            [weakSelf showTheMapDataWithArray:spaceListArray];
        } failed:nil];
    }];
}

/** 城市切换按钮 */
- (void)clickTitleButton:(UIButton *)btn {
    __weak typeof(self) weakSelf = self;
    NSString *beforeSelectedcity = [WSFSpaceListMapManager shareManager].selectedCityName;
    [[WSFSpaceListMapManager shareManager] pushToCityVCFormVC:self cityVCBack:^(NSString * _Nonnull cityName) {
        if ([cityName isEqualToString:beforeSelectedcity]) return ;
//        [weakSelf.titleBtn setTitle:cityName forState:UIControlStateNormal];
        [WSFSpaceListMapManager getConditionsSpaceListDataWithSuccess:^(NSArray * _Nonnull spaceListArray) {
            if (spaceListArray.count == 0 && ![[WSFSpaceListMapManager shareManager].selectedCityName isEqualToString:@"杭州市"]) {
                weakSelf.noServiceView.hidden = NO;
            }else {
                weakSelf.noServiceView.hidden = YES;
                [weakSelf showTheMapDataWithArray:spaceListArray];
            }
        } failed:nil];
    }];
}
/**  展示地图数据 */
- (void)showTheMapDataWithArray:(NSArray *)array {
    self.mapView.centerCoordinate = [WSFSpaceListMapManager shareManager].screenCoor;
    self.spaceListModelArray = [SpaceMessageModel getModelArrayFromModelArray:array];
    [self addPointAnnotation];
    [[WSFSpaceListMapManager shareManager] saveScreeningSpaceListArray:[self getTenArrayFormSpaceListModelArray:self.spaceListModelArray.mutableCopy]];
}

- (NSMutableArray *)getTenArrayFormSpaceListModelArray:(NSMutableArray *)array {
    if (array.count > 10) {
        for (NSInteger i = array.count - 1; i > 9; i--) {
            [array removeObjectAtIndex:i];
        }
    }
    return array;
}

//添加标注
- (void)addPointAnnotation {
    if(_mapView.annotations.count > 0) {
        [_mapView removeOverlays:_mapView.overlays];
        [_mapView removeAnnotations:_mapView.annotations];
    }
    NSMutableArray *array = [SpaceMessageModel getModelArrayForMapFromModelArray:_spaceListModelArray];
    for (SpaceMessageModel *model in array) {
        CustormPointAnnotation *annotation = [[CustormPointAnnotation alloc]init];
        annotation.model = model;
        annotation.annotationID = model.spaceId;
        annotation.pointCollectionArray = model.pointCollectionArray.mutableCopy;
        CLLocationCoordinate2D coor;
        coor.latitude = model.lat;
        coor.longitude = model.lng;
        annotation.coordinate = coor;
        annotation.title = @" ";
        annotation.subtitle = @" ";
        [_mapView addAnnotation:annotation];
    }
    _isFirst = YES;
}

- (void)setContentView {
    
    if ([MapViewManager shareMapViewInstance].mapVCView) {
        _mapView = [[MapViewManager shareMapViewInstance] mapVCView];
    }else {
        _mapView = [[MapViewManager shareMapViewInstance] getMapVCView];
    }
    _mapView.frame = SCREEN_BOUNDS;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    //类型--> 标准地图
    [_mapView setMapType:BMKMapTypeStandard];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    //定位
    if (_locService==nil) {
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
    }
    [_locService startUserLocationService];
    
    BMKLocationViewDisplayParam *testParam = [[BMKLocationViewDisplayParam alloc] init];
    testParam.isAccuracyCircleShow = false;// 精度圈是否显示
    testParam.locationViewImgName = @"icon_center_point";// 定位图标名称
    testParam.locationViewOffsetX = 0;
    testParam.locationViewOffsetY = 0;
    testParam.canShowCallOut = NO;
    [_mapView updateLocationViewWithParam:testParam]; //调用此方法后自定义定位图层生效
    
    _mapPin = [[UIButton alloc]init];
    _mapPin.frame = CGRectMake(SCREEN_WIDTH / 2 - 7.5, SCREEN_HEIGHT / 2 - 12.5 - 10, 15, 25);
    [_mapPin setImage:[UIImage imageNamed:@"zhongxindian"] forState:UIControlStateNormal];
    [self.view addSubview:_mapPin];
        
    //左下角定位按钮
    UIButton *positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    positionBtn.frame = CGRectMake(12, self.view.frame.size.height - 12 - 64 - 30, 30, 30);
    [positionBtn setImage:[UIImage imageNamed:@"map_position_black"] forState:UIControlStateNormal];
    [positionBtn addTarget:self action:@selector(positioningSelfLocationWith:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:positionBtn];
    [positionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.bottom.equalTo(self.view.mas_bottom).offset(-12);
        make.width.height.equalTo(@30);
    }];
}

/**  给定经纬度，从新获取数据并更新地图 */
- (void)upDateDateSourceWithlat:(double)lat lng:(double)lng {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [WSFSpaceListMapManager getMomentSpaceListDataWithLng:lng lat:lat success:^(NSArray * _Nonnull spaceListArray) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        weakSelf.spaceListModelArray = [SpaceMessageModel getModelArrayFromModelArray:spaceListArray];
        [weakSelf addPointAnnotation];
        if(weakSelf.locationType == WSFLocationType_locationAndData){
            [[WSFSpaceListMapManager shareManager] saveScreeningSpaceListArray:[weakSelf getTenArrayFormSpaceListModelArray:weakSelf.spaceListModelArray.mutableCopy]];
            weakSelf.locationType = WSFLocationType_defaultLocation;
        }
    } failed:^(NSError * _Nonnull error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

/**  重新定位，回到用户当前位置 */
- (void)positioningSelfLocationWith:(BOOL)isReset {
    __weak typeof(self) weakSelf = self;
    [[MapPositionManager sharedLocationManager] judgePositionWithBlock:^(BOOL isOpen) {
        if (isOpen) {
            weakSelf.locationType = isReset ?  WSFLocationType_locationAndData : WSFLocationType_selfLocation;
            [weakSelf.locService startUserLocationService];
        } else {
           [weakSelf presentViewController:weakSelf.alertVC animated:NO completion:nil];
        }
    }];
}

/**  同一个经纬度有多个点的时候显示下边的collectionView */
- (void)setBottonViewWith:(NSMutableArray<SpaceMessageModel *> *)modelArray {
    WSFMapSpsceListView *listView = [[WSFMapSpsceListView alloc]init];
    listView.dataArray = modelArray.mutableCopy;
    listView.currentVC = self;
    [listView showCollectionView];
    __weak typeof(self) weakSelf = self;
    listView.touchBlock = ^{
        [weakSelf setAnnotationViewSelectionState];
    };
}

/**  改变点和选中view的状态 */
- (void)setAnnotationViewSelectionState {
    CustormPointAnnotation *tempAnnotation = (CustormPointAnnotation *)_selectionView.annotation;
    if (tempAnnotation.pointCollectionArray.count > 1) {
        UIImage *image = [UIImage createShareImage:[UIImage imageNamed:@"map_didian_blue"] Context:[NSString stringWithFormat:@"%ld", (long)tempAnnotation.pointCollectionArray.count] textColor:[UIColor colorWithHexString:@"#2b84c6"]];
        _selectionView.image = image;
        _selectionView.selected = NO;
    }
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D mapCoordinate = [_mapView convertPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2) toCoordinateFromView:_mapView];
    NSLog(@"---屏幕中心点的经纬度----%f----%f", mapCoordinate.latitude, mapCoordinate.longitude);
    if (_isFirst) {
        [self upDateDateSourceWithlat:mapCoordinate.latitude lng:mapCoordinate.longitude];
    }
}

#pragma mark - BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];
    if (_locationType == WSFLocationType_locationAndData || _locationType == WSFLocationType_selfLocation){
        _mapView.centerCoordinate = userLocation.location.coordinate;
    }else{
        if ([WSFSpaceListMapManager shareManager].screenCoor.latitude > 0){
            _mapView.centerCoordinate = [WSFSpaceListMapManager shareManager].screenCoor;
        }else {
            _mapView.centerCoordinate = userLocation.location.coordinate;
        }
    }
    [_locService stopUserLocationService];
    _mapView.zoomLevel = ZoomLEVEl;
}

#pragma mark - BMKLocationServiceDelegate
//点击标注时调用的方法
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[CustormPointAnnotation class]]) {
        CustormPointAnnotation *tempAnnotation = (CustormPointAnnotation *)view.annotation;
        if (tempAnnotation.pointCollectionArray.count > 1) {
            UIImage *image = [UIImage createShareImage:[UIImage imageNamed:@"map_didian_gray"] Context:[NSString stringWithFormat:@"%ld",(long) (long)tempAnnotation.pointCollectionArray.count] textColor:[UIColor colorWithHexString:@"#808080"]];
            view.image = image;
            _selectionView = view;
            [self setBottonViewWith:tempAnnotation.pointCollectionArray];
        }
    }
}

//点击paopaoView时，对应的方法  (使用系统的paopaoView才会调用)
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
    CustormPointAnnotation *anntationV = (CustormPointAnnotation *)view.annotation;
    [self pushToDetailVCActionWithModel:anntationV.model];
}

//初始化标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[CustormPointAnnotation class]]) {
        BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"cell"];
        if (annotationView == nil) {
            annotationView = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"cell"];
        }
        
        CustormPointAnnotation *tempAnnotation = (CustormPointAnnotation *)annotation;
        if (tempAnnotation.pointCollectionArray.count == 1) {
            annotationView.image = [UIImage imageNamed:@"didian"];
            annotationView.canShowCallout = YES;
            
            //给paopaoView赋值
            _baiduView = [[PopViewOfBaidu alloc]initWithFrame:CGRectMake(0, 0, 124, 115)];
            _baiduView.model = tempAnnotation.model;
            BMKActionPaopaoView *pView =  [[BMKActionPaopaoView alloc]initWithCustomView:_baiduView];
            annotationView.paopaoView = nil;
            annotationView.paopaoView = pView;
            
            return annotationView;
        }else {
            annotationView.canShowCallout = NO;
            UIImage *image = [UIImage createShareImage:[UIImage imageNamed:@"map_didian_blue"] Context:[NSString stringWithFormat:@"%ld", (long)tempAnnotation.pointCollectionArray.count] textColor:[UIColor colorWithHexString:@"#2b84c6"]];
            annotationView.image = image;
            
            return annotationView;
        }
    }
    return nil;
}

- (void)pushToDetailVCActionWithModel:(SpaceMessageModel *)model {
    SpaceDetailViewController *spaceDetailVC = [[SpaceDetailViewController alloc] init];
    spaceDetailVC.SpaceId = model.spaceId;
    spaceDetailVC.inScreen = [WSFSpaceListMapManager shareManager].isInScreen;
    spaceDetailVC.screenCoor = [WSFSpaceListMapManager shareManager].screenCoor;
    spaceDetailVC.screenAddressStr = [WSFSpaceListMapManager shareManager].screenAddressStr;
    [self.navigationController pushViewController:spaceDetailVC animated:NO];
}

#pragma mark - 懒加载

- (WSFSpaceNoServiceView *)noServiceView {
    if (!_noServiceView) {
        __weak typeof(self) weakSelf = self;
        _noServiceView = [[WSFSpaceNoServiceView alloc] initWithFrame:self.view.bounds clickBlock:^{
            NSLog(@"联系有个空间了解更多:yingxiang@yinglai.ren");
            
            [[WSFSpaceListMapManager shareManager] resetScreenCityCondition];
            //标题View
            NSLog(@"[WSFSpaceListMapManager shareManager].selectedCityName~~%@",[WSFSpaceListMapManager shareManager].selectedCityName);
//            WSFButton *titleBtn = (WSFButton *)self.navigationItem.titleView;
//            [titleBtn setTitle:[WSFSpaceListMapManager shareManager].selectedCityName forState:UIControlStateNormal];
            SpaceListViewController *spaceListVC = (SpaceListViewController *)[self.navigationController hsm_viewControllerBaseOnClassName:@"SpaceListViewController"];
            [spaceListVC refreshListTableView];
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
        }];
    }
    [self.view addSubview:_noServiceView];
    [_noServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view bringSubviewToFront:_noServiceView];
    return _noServiceView;
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
