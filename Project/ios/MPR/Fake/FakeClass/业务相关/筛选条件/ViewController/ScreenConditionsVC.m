//
//  ScreenConditionsVC.m
//  WinShare
//
//  Created by GZH on 2017/5/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ScreenConditionsVC.h"
#import "HKLPickerView.h"
#import "SpaceModel.h"
#import "ChoosePeopleCountview.h"
#import "PositionLocationVC.h"
#import "WSFAppleDeviceString.h"
#import "MapPositionManager.h"

@interface ScreenConditionsVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) MapPositionManager *manager;              //地图功能的类
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) NSMutableArray *timeArray;                //预定的时间
@property (nonatomic, strong) NSMutableArray *peopleArray;              //预定的人数
@property (nonatomic, strong) ChoosePeopleCountview *chooseView;        //人数的collectionView
@property (nonatomic, strong) HKLPickerView *pickView;                  //选时间的控件
@property (nonatomic, strong) SpaceModel *model;                        //筛选时间上的匹配
@property (nonatomic, readwrite, assign) WSFScreenConditionsType screenConditionsType;
@property (nonatomic, readwrite, copy) NSString *currentTime;
@property (nonatomic, readwrite, copy) NSNumber *currentDuration;
@property (nonatomic, readwrite, copy) NSNumber *currentMinPeople;
@property (nonatomic, readwrite, copy) NSNumber *currentMaxPeople;
@property (nonatomic, readwrite, copy) NSString *locationStr;
@property (nonatomic, readwrite, assign) WSFScreenNumberOfPeople screenNumberOfPeople;

@end

@implementation ScreenConditionsVC

+ (instancetype) shareManager {
    static ScreenConditionsVC *staticInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticInstance = [[self alloc] init];
    }) ;
    return staticInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _screenConditionsType = WSFScreenConditionsType_Normal;
        _locationStr = @"";
        _currentTime = @"";
        _currentDuration = @0;
        _currentMinPeople = @0;
        _currentMaxPeople = @0;
        _screenNumberOfPeople.minNumber = 0;
        _screenNumberOfPeople.maxNumber = 0;
        _inScreen = NO;
    }
    return self;
}

#pragma mark - 布局
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[MapPositionManager sharedLocationManager] getCoorinate:^(CLLocationCoordinate2D coordinate) {
        _coor = coordinate;
    } address:^(CLPlacemark *placemark) {
//        _locationStr = placemark.name;
//        _locationLabel.text = _locationStr;
    } error:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _timeArray = [NSMutableArray arrayWithObjects:@"",[NSNumber numberWithInteger:0], nil];
    _peopleArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    
    [self setContentView];
    [self setBottomButtonView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetControllersAction) name:WSFScreenResetNotification object:nil];
}

- (void)setBottomButtonView {
    UIView *backView = [UIView Z_createViewWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - 64, SCREEN_WIDTH, 50) colorStr:@"#2b84c6"];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.bottom.right.equalTo(self.view);
      make.height.equalTo(@50);
    }];
    
    UIView *lineView = [UIView Z_createViewWithFrame:CGRectMake(SCREEN_WIDTH/2 - 0.5, 18, 1.0, 14) colorStr:@"#ffffff"];
    [backView addSubview:lineView];
    
    UIButton *resetBtn = [UIButton Z_createButtonWithTitle:@"重置" buttonFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, 50) layerMask:NO textFont:16 colorStr:nil cornerRadius:1.0];
    [resetBtn addTarget:self action:@selector(resetControllersAction) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:resetBtn];
    
    UIButton *sureBtn = [UIButton Z_createButtonWithTitle:@"确定" buttonFrame:CGRectMake(lineView.right, 0, SCREEN_WIDTH / 2, 50) layerMask:NO textFont:16 colorStr:nil cornerRadius:1.0];
    [sureBtn addTarget:self action:@selector(beSureAction) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:sureBtn];
}

- (void)setContentView {
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50)];
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //判断是4或者4s的话是可以滑动的
    NSString *device = [WSFAppleDeviceString deviceString];
    if ([device containsString:@"4"] || [device containsString:@"4S"]) {
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 130);
    }
    
    UILabel *positionLabel = [UILabel Z_createLabelWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 50) title:@"地点" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    [_scrollView addSubview:positionLabel];
    
    UIView *positionView = [UIView Z_createViewWithFrame:CGRectMake(0, positionLabel.bottom, SCREEN_WIDTH, 50) colorStr:@"#e5e5e5"];
    [_scrollView addSubview:positionView];
    
    UIImageView *locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 13, 15)];
    locationImage.image = [UIImage imageNamed:@"dibiao_big"];
    [positionView addSubview:locationImage];
    
    self.locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(locationImage.right + 10, 0, SCREEN_WIDTH - locationImage.right - 10 - 30, 50)];
    self.locationLabel.font = [UIFont systemFontOfSize:14];
    self.locationLabel.text = @"杭州";
    self.locationLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getPositionAction)];
    [self.locationLabel addGestureRecognizer:tap];
    [positionView addSubview:self.locationLabel];
    
    UIImageView *signImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 9, 17, 9, 16)];
    signImage.image = [UIImage imageNamed:@"xiangyou_black"];
    [positionView addSubview:signImage];
    
    UILabel *timeLabel = [UILabel Z_createLabelWithFrame:CGRectMake(10, positionView.bottom + 25, SCREEN_WIDTH - 20, 19) title:@"时间" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    [_scrollView addSubview:timeLabel];
    
    
    _pickView = [[HKLPickerView alloc]initWithFrame:CGRectMake(0, timeLabel.bottom + 12, SCREEN_WIDTH, 179)];
    _model = [[SpaceModel alloc]initWithData];
    _pickView.dataSource = @[_model.dataArray,_model.pointTimeArray,_model.timeArray];
    if (self.currentTime != NULL) {
        _pickView.selectedArray = @[self.currentTime, self.currentDuration];
    }
    [_scrollView addSubview:_pickView];
    
    UILabel *peopleLabel = [UILabel Z_createLabelWithFrame:CGRectMake(10, _pickView.bottom + 25, SCREEN_WIDTH - 20, 19) title:@"人数" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    [_scrollView addSubview:peopleLabel];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(60, 36);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    _chooseView = [[ChoosePeopleCountview alloc]initWithFrame:CGRectMake(10, peopleLabel.bottom + 12, SCREEN_WIDTH - 20, 36) collectionViewLayout:layout];
    _chooseView.currentMinPeople = self.currentMinPeople;
    _chooseView.scrollsToTop = NO;
    [_scrollView addSubview:_chooseView];
    
    
    __weak typeof(self) weakSelf = self;
    //时间
    [_pickView setConfirmBtnClickBlock:^(NSArray *contents, NSArray *array) {
        
        [weakSelf.timeArray replaceObjectAtIndex:0 withObject:array[0]];
        
        if ([array[0] isEqualToString:@""]) {
            weakSelf.currentDuration = @0;
            weakSelf.currentTime = @"";
            [weakSelf.timeArray replaceObjectAtIndex:1 withObject:@0];
        }else {
            [weakSelf.timeArray replaceObjectAtIndex:1 withObject:array[1]];
        }
    }];
    
    
    //人数
    _chooseView.peopleCountBlock = ^(NSArray *array) {
        weakSelf.currentMinPeople = array[0];
        weakSelf.currentMaxPeople = array[1];
        
        _screenNumberOfPeople.minNumber = [array[0] intValue];
        _screenNumberOfPeople.maxNumber = [array[1] intValue];
    };
    
}

#pragma mark - 点击事件
- (void)getPositionAction {
    //地点
    PositionLocationVC *positionVC = [[PositionLocationVC alloc]init];
    positionVC.positionBlock = ^(NSString *str, CLLocationCoordinate2D coor) {
        _locationLabel.text = [NSString stringWithFormat:@"杭州·%@", str];
        _coor =  coor;
        _locationStr = str;
    };
    positionVC.locationStr = _locationStr;
    [self.navigationController pushViewController:positionVC animated:NO];
}

// 重置按钮
- (void)resetControllersAction {
    [[MapPositionManager sharedLocationManager] getCoorinate:^(CLLocationCoordinate2D coordinate) {
        _coor = coordinate;
        self.currentMinPeople = @0;
        self.currentMaxPeople = @0;
        _screenNumberOfPeople.minNumber = 0;
        _screenNumberOfPeople.maxNumber = 0;
        self.chooseView.currentMinPeople = [NSNumber numberWithInteger:0];
        self.currentTime = @"";
        self.currentDuration = @0;
        _pickView.reSetStr = @"reset";
        
        _timeArray[0] = @"";
        _timeArray[1] = @0;
        _inScreen = NO;
        _locationStr = @"";
        _locationLabel.text = @"杭州";
        
        if (_screenConditionsType == WSFScreenConditionsType_InTheScreen) {
            if (_resetScreeningBlock) {
                _resetScreeningBlock();
            }
        }
        
        _screenConditionsType = WSFScreenConditionsType_Normal;
    } address:^(CLPlacemark *placemark) {
        if(_resetPlacemark)_resetPlacemark(placemark);
    } error:nil];
}

// 确定按钮
- (void)beSureAction {
    _screenConditionsType = WSFScreenConditionsType_InTheScreen;
    if ([_timeArray[0] isEqualToString:@""] && self.currentTime != nil) {
        [_timeArray replaceObjectAtIndex:0 withObject:self.currentTime];
        [_timeArray replaceObjectAtIndex:1 withObject:self.currentDuration];
    }
    if (self.currentMinPeople != NULL) {
        [_peopleArray replaceObjectAtIndex:0 withObject:self.currentMinPeople];
        [_peopleArray replaceObjectAtIndex:1 withObject:self.currentMaxPeople];
    }
    
    _currentTime = _timeArray[0];
    _currentDuration = _timeArray[1];
    if(_conditionsBlock)_conditionsBlock(_coor, _locationStr, _timeArray, _peopleArray);
    _inScreen = YES;
    
    [self.navigationController popViewControllerAnimated:NO];
    if (self.completeScreeningBlock) {
        self.completeScreeningBlock();
    }
}

// 返回
- (void)doBackAction {
    [super doBackAction];
    if (_screenConditionsType == WSFScreenConditionsType_Normal) {
        [self resetControllersAction];
    }
}

@end
