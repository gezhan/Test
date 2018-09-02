//
//  SearchVC.m
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//


#import "SearchVC.h"
#import "RootTableViewCell.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTEventEmitter.h>
#import <CoreLocation/CoreLocation.h>
@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource,
UITextFieldDelegate,AMapSearchDelegate>
@property(nonatomic, strong)NSArray *rootArr;
@property (weak, nonatomic) IBOutlet UITextField *rootTextField;
@property(nonatomic, strong)AMapSearchAPI*search;
@property(nonatomic, strong)AMapGeocodeSearchRequest*geo;
@property(nonatomic, strong) NSString *latitudeLocation;//经度
@property(nonatomic, strong) NSString *longitudeLocation;//纬度
@property (nonatomic, strong)NSString *province;//省
@property(nonatomic, strong) NSString *city;//市
@property(nonatomic, strong) NSString * district;//区
@end

@implementation SearchVC
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE();
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  self.searchView.layer.masksToBounds = YES;
  self.searchView.layer.cornerRadius = 6;
    [_rootTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_rootTextField becomeFirstResponder];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    _geo = [[AMapGeocodeSearchRequest alloc] init];
    _rootTableView.delegate = self;
    _rootTableView.dataSource = self;
    _rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"%@", theTextField.text);
    //发起输入提示搜索
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = theTextField.text;
    [_search AMapInputTipsSearch: tipsRequest];
    
}


-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response

{
    if (response.tips.count == 0)
    {
        return;
    }
    _rootArr = [NSArray arrayWithArray:response.tips];
    [_rootTableView reloadData];
    //解析response获取地理信息，具体解析见 Demo
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rootArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 62;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditCardCell4"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"RootTableViewCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_rootArr.count != 0) {
        //        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:_rootArr[indexPath.row]];
  
    }
    if (_rootArr.count != 0) {
        AMapTip*tip = _rootArr[indexPath.row];
        cell.titles.text = tip.name;
        cell.detaile.text = [NSString stringWithFormat:@"%@%@",tip.district,tip.address];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_rootTextField resignFirstResponder];
  AMapTip*tip = _rootArr[indexPath.row];
  NSString *name = [NSString stringWithFormat:@"%@",tip.name];
  self.latitudeLocation = [NSString stringWithFormat:@"%f",tip.location.latitude];
  self.longitudeLocation = [NSString stringWithFormat:@"%f",tip.location.longitude];
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  //根据经纬度反向地理编译出地址信息
  CLLocation *aa = [[CLLocation alloc]initWithLatitude:tip.location.latitude longitude:tip.location.longitude];
  [geocoder reverseGeocodeLocation:aa completionHandler:^(NSArray *array, NSError *error)
   {
     if (array.count > 0)
     {
       CLPlacemark *placemark = [array objectAtIndex:0];
       NSString *city = placemark.locality;
       if (!city) {
         city = placemark.administrativeArea;
       }
       NSDictionary *address = placemark.addressDictionary;
       self.province = [NSString stringWithFormat:@"%@",address[@"State"]];
       self.city = [NSString stringWithFormat:@"%@",address[@"City"]];
       self.district = [NSString stringWithFormat:@"%@",address[@"SubLocality"]];
			 NSDictionary *dic = @{@"name":name,@"province":self.province,@"city":self.city,@"district":self.district,@"latitudeLocation":self.latitudeLocation,@"longitudeLocation":self.longitudeLocation,@"ret":@1};

       [[NSNotificationCenter defaultCenter] postNotificationName:@"noti3" object:nil userInfo:dic];
       
       UIViewController *present = self.presentingViewController;
       while (YES) {
         if (present.presentingViewController) {
           present = present.presentingViewController;
         }else{
           break;
         }
       }
       [present dismissViewControllerAnimated:YES completion:nil];
     }
     
   }];
  
}



- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)dealloc {
	[[NSNotificationCenter defaultCenter]removeObserver:self name:@"noti3" object:nil];
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
