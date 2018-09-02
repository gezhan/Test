//
//  WSFHomePageTHView.m
//  WinShare
//
//  Created by GZH on 2018/1/10.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageTHView.h"
#import "WSFHomePageHotCView.h"
#import "WSFHomePagePromptView.h"
#import "SpaceListViewController.h"
#import "WSFFieldVC.h"
#import "WSFHomePageVM.h"
#import "SpaceDetailViewController.h"
#import "WSFFieldDetailVC.h"
#import "WSFHomePageLinkVC.h"
#import "WSFActivityListVC.h"
#import "WSFActivityDetailVC.h"

@interface WSFHomePageTHView() <SDCycleScrollViewDelegate>
/**  轮播图 */
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
/**  热门空间的collectionView */
@property (nonatomic, strong) WSFHomePageHotCView *hotCView;
@end
@implementation WSFHomePageTHView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setContentView];
    }
    return self;
}

- (void)setHomePageVM:(WSFHomePageVM *)homePageVM {
    _homePageVM = homePageVM;
    NSMutableArray *photosUrlArray = [NSMutableArray array];
    for (WSFHomePageCarouselItemVM *itemM in homePageVM.carouselArray) {
        [photosUrlArray addObject:itemM.picture];
    }
    self.cycleScrollView.imageURLStringsGroup = photosUrlArray;
    self.hotCView.hotRoomArray = homePageVM.hotRoomArray;
}


- (void)setContentView {
    self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    //轮播图片
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16) delegate:self placeholderImage:[UIImage imageNamed:@"logo_big_bg"]];
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycleScrollView.imageURLStringsGroup = @[];
    self.cycleScrollView.autoScrollTimeInterval = 4.0;
    [self addSubview:self.cycleScrollView];

    //小包厢，大场地
    UIView *backView1 = [[UIView alloc]init];
    backView1.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self addSubview:backView1];
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@108);
    }];
    NSArray *array = @[@"home_baoxiang_small", @"home_changdi_big", @"home_huodong_green"];
//    NSArray *array = @[@"", @"", @""];
    CGFloat gapWidth = (SCREEN_WIDTH-270)/(1 + array.count);
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(jumptoListViewController:) forControlEvents:UIControlEventTouchDown];
        [backView1 addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backView1).offset(20);
            make.left.equalTo(backView1).offset(gapWidth + (gapWidth + 90) * i);
            make.size.mas_equalTo(CGSizeMake(90, 70));
        }];
    }
    
    //热门空间
    UIView *backView2 = [[UIView alloc]init];
    backView2.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView1.mas_bottom).offset(15);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-15);
    }];
    
    //热门空间
    WSFHomePagePromptView *promptView = [[WSFHomePagePromptView alloc]initWithFrame:CGRectZero signString:@"热门空间"];
    [backView2 addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView2.mas_top);
        make.left.right.equalTo(backView2);
        make.height.equalTo(@52);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 15;
    self.hotCView = [[WSFHomePageHotCView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.hotCView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.hotCView .scrollsToTop = NO;
    [self addSubview:self.hotCView ];
    [self.hotCView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptView.mas_bottom);
        make.left.equalTo(backView2).offset(10);
        make.right.equalTo(backView2).offset(-10);
        make.bottom.equalTo(backView2.mas_bottom);
    }];
}

/**  跳到小包厢，大场地 */
- (void)jumptoListViewController:(UIButton *)sender {
    if (sender.tag == 0) {
        //跳到小包厢列表界面
        SpaceListViewController *spaceVC = [[SpaceListViewController alloc]init];
        [self.viewController.navigationController pushViewController:spaceVC animated:NO];
    }else if (sender.tag == 1){
        //跳到大场地列表界面
        WSFFieldVC *playVC = [[WSFFieldVC alloc]init];
        [self.viewController.navigationController pushViewController:playVC animated:NO];
    }else {
        //跳到活动列表界面
        WSFActivityListVC *VC = [[WSFActivityListVC alloc]init];
        [self.viewController.navigationController pushViewController:VC animated:NO];
    }
}

#pragma mark - 图片轮播的协议方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    WSFHomePageCarouselItemVM *itemM  = _homePageVM.carouselArray[index];
    if (itemM.jumpTypeKey == 1) {
        //小包厢
        SpaceDetailViewController *spaceDetailVC = [[SpaceDetailViewController alloc] init];
        spaceDetailVC.SpaceId = itemM.jumpRoomId;
        [self.viewController.navigationController pushViewController:spaceDetailVC animated:NO];
    }else if (itemM.jumpTypeKey == 2) {
        //大场地
        WSFFieldDetailVC *detailVC = [[WSFFieldDetailVC alloc]init];
        detailVC.roomId = itemM.jumpRoomId;
        [self.viewController.navigationController pushViewController:detailVC animated:NO];
    }else if (itemM.jumpTypeKey == 3) {
        //链接
        WSFHomePageLinkVC *linkVC = [[WSFHomePageLinkVC alloc]init];
        linkVC.requestURL = itemM.jumpUrl;
        [self.viewController.navigationController pushViewController:linkVC animated:NO];
    }else {
        //活动
        WSFActivityDetailVC *detailVC = [[WSFActivityDetailVC alloc]init];
        detailVC.eventId = itemM.jumpRoomId;
        [self.viewController.navigationController pushViewController:detailVC animated:NO];
        
        NSLog(@"--------活动" );
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
