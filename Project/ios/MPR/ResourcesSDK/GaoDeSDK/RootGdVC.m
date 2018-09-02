//
//  RootGdVC.m
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//


#import "RootGdVC.h"
#import "RootTableViewCell.h"
#import "SearchVC.h"
#define ColorRgbValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >>16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]

#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface RootGdVC ()<MAMapViewDelegate,AMapLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,AMapSearchDelegate,CLLocationManagerDelegate>{
  NSInteger _page;//分页
  NSInteger _ncxstatus;//逆查询地址状态
}
@property(nonatomic, strong) CLLocation * currentLocation;
@property(nonatomic, strong) CLLocationManager *locationManagers;
@property(nonatomic, strong) NSString *latitudeLocation;//经度
@property(nonatomic, strong) NSString *longitudeLocation;//纬度
@property (nonatomic, strong)NSString *province;//省
@property(nonatomic, strong) NSString *city;//市
@property(nonatomic, strong) NSString * district;//区

@property (nonatomic, assign) BOOL locatingWithReGeocode;
//定位
@property (nonatomic, strong) AMapLocationManager *locationManager;
//地图
@property (nonatomic, strong) MAMapView *mapView;
//大头针
@property (nonatomic, strong) MAPointAnnotation *annotation;
//逆地理编码
@property (nonatomic, strong) AMapReGeocodeSearchRequest *regeo;
//逆地理编码使用的
@property (nonatomic, strong) AMapSearchAPI *search;
@property(nonatomic, strong)NSMutableArray *dataArr;
@property(nonatomic, strong)NSMutableArray *rootArr;



@end

@implementation RootGdVC

- (AMapLocationManager *)locationManager {
  if (!_locationManager) {
    _locationManager = [[AMapLocationManager alloc]init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
  }
  return _locationManager;
}

- (AMapReGeocodeSearchRequest *)regeo {
  if (!_regeo) {
    _regeo = [[AMapReGeocodeSearchRequest alloc]init];
    _regeo.requireExtension = YES;
  }
  return _regeo;
}

- (AMapSearchAPI *)search {
  if (!_search) {
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
  }
  return _search;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti3:) name:@"noti3" object:nil];
  self.navigationController.navigationBar.translucent = YES;
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self nav];
  //搜索结果tableView
  self.rootTableView.delegate = self;
  self.rootTableView.dataSource = self;
  self.rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.rootTableView.backgroundColor = [UIColor whiteColor];
  self.rootTableView.mj_header = [self headerRe];
  
  _page = 0;
  
  //地图
  _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, WIDTH  , self.topView.frame.size.height)];
//  NSLog(@"width == %.2f",_mapView.frame.size.width);
  [self.topView addSubview:_mapView];
  _mapView.showsUserLocation = YES;
  _mapView.delegate = self;
  _mapView.userTrackingMode = MAUserTrackingModeFollow;
  _mapView.showsScale = YES;
  
  //定位
  [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
    
    if (error) {
      return ;
    }
    //添加大头针//让地图在缩放过程中移到当前位置试图

    [_mapView setZoomLevel:14.5 animated:YES];
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude) animated:NO];
    
    _annotation = [[MAPointAnnotation alloc]init];
    _annotation.lockedScreenPoint = CGPointMake(WIDTH / 2, 290/2);
//    NSLog(@"width == %.2f",WIDTH);
//    _annotation.lockedScreenPoint = self.topView.center;
//    NSLog(@"%.2f ----- %.2f",self.topView.center.x,self.topView.center.y);
    [_annotation setLockedToScreen:YES];
    
    [_mapView addAnnotation:_annotation];
    
    
    
  }];
  
}
//nav
-(void)nav{

//  self.navigationController.view.backgroundColor = ColorRgbValue(0x1d9ff9);
  self.navigationController.navigationBar.barTintColor = ColorRgbValue(0x4e89eb);
  //[self.view setBackgroundColor:[UIColor whiteColor]];
  UIImage *aimage = [UIImage imageNamed:@"back_black"];
  UIImage *image = [aimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
  self.navView.layer.masksToBounds = YES;
  self.navView.layer.cornerRadius = 6;
  self.navView.frame = CGRectMake(0, 0, WIDTH, 25);
  self.navigationItem.titleView =self.navView;
  
}
-(void)noti3:(NSNotification *)noti{
	NSDictionary  *dic = [noti userInfo];
	NSLog(@"$$$$$$$$$$$$$$$$$:%@",dic);
	self.callBack(@[dic]);
}
- (void)leftItemAction{
	NSDictionary *dic = @{@"ret":@0};
	self.callBack(@[dic]);
  [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return _rootArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditCardCell4"];
  if (!cell) {
    cell = [[NSBundle mainBundle]loadNibNamed:@"RootTableViewCell" owner:self options:nil].lastObject;
  }
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  if (_rootArr.count != 0) {
    //        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:_rootArr[indexPath.row]];
    AMapTip *poi = _rootArr[indexPath.row];
    if (poi.name) {
      cell.titles.text = [NSString stringWithFormat:@"%@",poi.name];
    }else{
      cell.titles.text = [NSString stringWithFormat:@""];
    }
    if (poi.address) {
      cell.detaile.text = [NSString stringWithFormat:@"%@",poi.address];
    }else{
      cell.detaile.text = [NSString stringWithFormat:@""];
    }
    
  }
  
  
  
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  AMapTip*tip = _rootArr[indexPath.row];
  NSString* name = [NSString stringWithFormat:@"%@",tip.name];
  self.latitudeLocation = [NSString stringWithFormat:@"%f",tip.location.latitude];
  self.longitudeLocation = [NSString stringWithFormat:@"%f",tip.location.longitude];
  
  NSDictionary *dic = @{@"name":name,@"province":self.province,@"city":self.city,@"district":self.district,@"latitudeLocation":self.latitudeLocation,@"longitudeLocation":self.longitudeLocation,@"ret":@1};

  self.callBack(@[dic]);
  [self dismissViewControllerAnimated:YES completion:nil];
}





- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
  
  if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
            static NSString *reuseIdetifier = @"annotationReuseIndetifier";
            MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdetifier];
            if (annotationView == nil) {
                annotationView = [[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:reuseIdetifier];
            }
            //放一张大头针图片即可
            annotationView.image = [UIImage imageNamed:@"定位2"];
//            annotationView.centerOffset = CGPointMake(0, -18);
            annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
            annotationView.draggable = YES;        //设置标注可以拖动，默认为NO

    
    return annotationView;
  }
  
  return nil;
}

#pragma mark - 滑动地图结束修改当前位置
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
  NSLog(@"滑动地图结束修改当前位置 0");
}

#pragma mark - 滑动地图结束修改当前位置
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
  self.regeo.location = [AMapGeoPoint locationWithLatitude:mapView.centerCoordinate.latitude longitude:mapView.centerCoordinate.longitude];
  [self.search AMapReGoecodeSearch:self.regeo];
  NSLog(@"滑动地图结束修改当前位置 1");
}

#pragma mark - 地图将要发生移动时调用此接口
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
  NSLog(@"地图将要发生移动时调用此接口 2");
}

#pragma mark - 地图移动结束后调用此接口
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
  NSLog(@"地图移动结束后调用此接口 3");
}

#pragma mark - 地图将要发生缩放时调用此接口
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction{
  NSLog(@"地图将要发生缩放时调用此接口 4");
}

#pragma mark - 地图缩放结束后调用此接口
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction{
  NSLog(@"地图缩放结束后调用此接口 5");
}




- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
  if (response.regeocode != nil) {
    //地图标注的点的位置信息全在reoceode里面了
    //解析response获取地址描述，具体解析见 Demo
    if (response.regeocode.addressComponent) {
      if (response.regeocode.addressComponent.province) {
        self.province = [NSString stringWithFormat:@"%@",response.regeocode.addressComponent.province];
      }else{
        self.province = [NSString stringWithFormat:@""];
      }
      if (response.regeocode.addressComponent.city) {
        self.city = [NSString stringWithFormat:@"%@",response.regeocode.addressComponent.city];
      }else{
        self.city = [NSString stringWithFormat:@""];
      }
      if (response.regeocode.addressComponent.district) {
        self.district = [NSString stringWithFormat:@"%@",response.regeocode.addressComponent.district];
      }else{
        self.district = [NSString stringWithFormat:@""];
      }

    }
    
    
    self.rootTableView.mj_footer = [self footerRe];
    if (response.regeocode && response.regeocode.pois) {
      self.dataArr = [NSMutableArray arrayWithArray:response.regeocode.pois];
    }else{
      self.dataArr = @[].mutableCopy;
    }
    if (self.dataArr) {
      AMapTip*tip = _dataArr[0];
      _annotation.title = [NSString stringWithFormat:@"%@",tip.name];
      if (_dataArr.count >= 10) {
        
        _page = _dataArr.count % 10  ?  _dataArr.count / 10 - 2  :  _dataArr.count / 10 - 1;
        _rootArr = @[].mutableCopy;
        for (int i = 0; i<10 ; i++) {
          
          [_rootArr addObject:_dataArr[i]];
//          NSLog(@"%@",[_dataArr[i] valueForKey:@"name"]);
        }
        [_dataArr removeObjectsInRange:NSMakeRange(0, 10)];
      }else{
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态
        [self.rootTableView.mj_footer endRefreshingWithNoMoreData];
        _rootArr = [NSMutableArray arrayWithArray:response.regeocode.pois];
        _page = 0;
      }
      
      [_rootTableView setContentOffset:CGPointMake(0, 0)];
      [_rootTableView reloadData];
    }
    
  }
}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)searchaction:(id)sender {
  SearchVC *search = [[SearchVC alloc]initWithNibName:@"SearchVC" bundle:nil];
  search.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  [self presentViewController:search animated:YES completion:^{
    
  }];
}
#pragma mark --- 刷新加载 -----
-(void)headerReoadData{
  [self.rootTableView.mj_header endRefreshing];
}
-(void)footerReadData{
  
  if (_page == 0) {
    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
    [self.rootTableView.mj_footer endRefreshingWithNoMoreData];
  }else{
    if (_dataArr.count != 0) {
      if (_dataArr.count >= 10) {
        for (int i = 0; i < 10; i++) {
          [_rootArr addObject:_dataArr[i]];
        }
        
        [_dataArr removeObjectsInRange:NSMakeRange(0, 10)];
        
      }else{
        for (int i = 0; i < _dataArr.count; i++) {
          [_rootArr addObject:_dataArr[i]];
        }
//        NSLog(@"%@",_rootArr);
        [_dataArr removeObjectsInRange:NSMakeRange(0, _dataArr.count-1)];
//        NSLog(@"%@",_dataArr);
      }
      _page = _page -1;
    }
    
    
    // 拿到当前的上拉刷新控件，结束刷新状态
    [_rootTableView.mj_footer endRefreshing];
    [_rootTableView reloadData];
  }
  
}
//自定义刷新
-(MJRefreshNormalHeader *)headerRe{
  MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerReoadData)];
  
  // 设置文字
  [header setTitle:@"下拉刷新地址" forState:MJRefreshStateIdle];
  
  [header setTitle:@"刷新中 ..." forState:MJRefreshStateRefreshing];
  
  // 设置字体
  header.stateLabel.font = [UIFont systemFontOfSize:15];
  header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
  
  // 设置颜色
  header.stateLabel.textColor = [UIColor blackColor];
  header.lastUpdatedTimeLabel.textColor = [UIColor blackColor];
  
  // 马上进入刷新状态
  [header beginRefreshing];
  return header;
}
//自定义加载
-(MJRefreshAutoNormalFooter *)footerRe{
  MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerReadData)];
  
  // 设置文字
  [footer setTitle:@"上拉加载更多地址" forState:MJRefreshStateIdle];
  [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
  [footer setTitle:@"没有更多地址信息" forState:MJRefreshStateNoMoreData];
  
  // 设置字体
  footer.stateLabel.font = [UIFont systemFontOfSize:15];
  
  // 设置颜色
  footer.stateLabel.textColor = [UIColor blackColor];
  
  // 设置footer
  return footer;
}

-(void)dealloc {
  _rootTableView.mj_footer = nil;
  _rootTableView.mj_header = nil;
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
