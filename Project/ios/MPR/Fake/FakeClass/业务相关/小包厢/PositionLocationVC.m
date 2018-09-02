//
//  PositionLocationVC.m
//  WinShare
//
//  Created by GZH on 2017/5/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "PositionLocationVC.h"
#import "SearchSpaceCell.h"
#import "BaiduHeader.h"
#import "PositionModel.h"
#import "MapPositionManager.h"

@interface PositionLocationVC ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) NSMutableArray *cityDataArr; //存储附近的地点
  //加载的gif图
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, strong) MapPositionManager *manager; //地图功能的类

@end


@implementation PositionLocationVC

- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 45, SCREEN_WIDTH,  self.view.size.height- 64 - 45);
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        //设置分割线的风格
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //设置分割线距边界的距离
        _tableView.separatorInset = UIEdgeInsetsMake(0, 45, 0, 0);
        //tableView开始滚动，键盘回收
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
    self.cityDataArr = [NSMutableArray array];
    _integer = 0;
    
     _manager = [MapPositionManager sharedLocationManager];
    
    [self setContentView];
    
    if(_locationStr.length > 0)[self sendOptionAction:_locationStr];
}

- (void)sendOptionAction:(NSString *)keyWord {
    if (kNetworkNotReachability) {
        [MBProgressHUD showMessage:@"请连接网络！"];
        return;
    }
    if(keyWord.length == 0) return;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_manager getResultArrayWithKeyWordString:keyWord andPageIndex:0 pageNumber:15 array:^(NSArray<BMKPoiInfo *> *array) {
        [self.cityDataArr removeAllObjects];
        for(BMKPoiInfo *poiInfo in array) {
            PositionModel *model=[[PositionModel alloc]init];
            model.name = poiInfo.name;
            model.address = poiInfo.address;
            model.coor = poiInfo.pt;
            [self.cityDataArr addObject:model];
            [self.tableView reloadData];
        }
        [self loadingHUDhiddenAction];
    } error:^(ErrorCode error) {
        _integer++;
        if (error != 0) {
            if (_locationStr.length > 4 && _integer == 1) {
                _locationStr = [_locationStr substringToIndex:4];
                [self sendOptionAction:_locationStr];
            }else
                if (_locationStr.length > 1 && _integer == 2) {
                    _locationStr = [_locationStr substringToIndex:1];
                    [self sendOptionAction:_locationStr];
                }else {
                    [MBProgressHUD showMessage:@"抱歉，未找到结果"];
                }
            [self loadingHUDhiddenAction];
        }else {
            [MBProgressHUD showMessage:@"抱歉，未找到结果"];
            [self loadingHUDhiddenAction];
        }
    }];
}

- (void)getNearlyAddressAction {
    
}

- (void)setContentView {
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    _headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *signImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 14)];
    signImage.image = [UIImage imageNamed:@"sousuo"];
    [_headerView addSubview:signImage];
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(signImage.right + 10, 0, SCREEN_WIDTH - signImage.right - 10 - 15, 45)];
    _textfield.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    _textfield.delegate = self;//设置代理
    _textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textfield addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    _textfield.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    _textfield.font = [UIFont systemFontOfSize:14];
    //_textfield.text = @"杭州市江干区迪凯银座";
    [_headerView addSubview:_textfield];
    [_textfield becomeFirstResponder];
    
    [self.view addSubview:_headerView];
    [self.view addSubview:self.tableView];
    
    _textfield.text = _locationStr;
}

- (void)valueChanged:(UITextField *)sender {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cityDataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.cityDataArr.count > 0) {
        PositionModel *positionModel = self.cityDataArr[indexPath.row];
        if(_positionBlock)_positionBlock(positionModel.name, positionModel.coor);
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchSpaceCell *cell = cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[SearchSpaceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.cityDataArr.count > 0) {
        PositionModel *positionModel = self.cityDataArr[indexPath.row];
        cell.positionModel = positionModel;
    }
    return cell;
}


- (void)loadingHUDhiddenAction {
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            subView.hidden = YES;
        }
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _integer = 0;
    _locationStr = textField.text;
    [self sendOptionAction:_locationStr];
    return YES;
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
