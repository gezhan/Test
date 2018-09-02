//
//  SpaceMessageTView.m
//  WinShare
//
//  Created by QIjikj on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceMessageTView.h"
#import "SpaceMessageCell.h"
#import "SpaceDetailViewController.h"
#import "SpaceMessageModel.h"
#import "WSFSpaceListMapManager.h"
#import "WSFButton+HSF_Composition.h"
#import "SpaceListViewController.h"
#import "WSFSpaceNoServiceView.h"

@interface SpaceMessageTView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *noDataDisplayView;
@property (nonatomic, strong) WSFSpaceNoServiceView *noServiceView;

@end

@implementation SpaceMessageTView
@synthesize spaceListArray = _spaceListArray;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setSpaceListArray:(NSArray *)spaceListArray
{
    _spaceListArray = spaceListArray;
    
    if (self.spaceListArray.count == 0 && ![[WSFSpaceListMapManager shareManager].selectedCityName isEqualToString:@"杭州市"]) {
        self.backgroundView = self.noServiceView;
        [self reloadData];
    }else {
        self.backgroundView = nil;
        [self tableViewDisplayNotFoundViewWithRowCount:spaceListArray.count withImageName:@"kongjian_none"];
        [self reloadData];
    }
    
}

#pragma mark - tableViewDataSource,UITableViewDelegate
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.spaceListArray.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpaceMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpaceMessageCell"];
    if (!cell) {
        cell = [[SpaceMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SpaceMessageCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SpaceMessageModel *spaceMessageModel = [self.spaceListArray objectAtIndex:indexPath.row];
    cell.spaceModel = spaceMessageModel;
    
    return cell;
}

// 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//当已经点击cell时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SpaceDetailViewController *spaceDetailVC = [[SpaceDetailViewController alloc] init];
    SpaceMessageModel *spaceMessageModel = [self.spaceListArray objectAtIndex:indexPath.row];
    spaceDetailVC.SpaceId = spaceMessageModel.spaceId;
    spaceDetailVC.inScreen = [WSFSpaceListMapManager shareManager].isInScreen;
    spaceDetailVC.screenCoor = [WSFSpaceListMapManager shareManager].screenCoor;
    spaceDetailVC.screenAddressStr = [WSFSpaceListMapManager shareManager].screenAddressStr;
    [self.viewController.navigationController pushViewController:spaceDetailVC animated:NO];
}

#pragma mark - lazyLoad

- (NSArray *)spaceListArray
{
    if (!_spaceListArray) {
        _spaceListArray = [[NSArray alloc] init];
    }
    return _spaceListArray;
}

- (WSFSpaceNoServiceView *)noServiceView
{
    if (!_noServiceView) {
        _noServiceView = [[WSFSpaceNoServiceView alloc] initWithFrame:self.bounds clickBlock:^{
            NSLog(@"联系有个空间了解更多:yingxiang@yinglai.ren");
            
            [[WSFSpaceListMapManager shareManager] resetScreenCityCondition];
            //标题View
            NSLog(@"[WSFSpaceListMapManager shareManager].selectedCityName~~%@",[WSFSpaceListMapManager shareManager].selectedCityName);
            WSFButton *titleBtn = (WSFButton *)self.viewController.navigationItem.titleView;
            [titleBtn setTitle:[WSFSpaceListMapManager shareManager].selectedCityName forState:UIControlStateNormal];
            
            [(SpaceListViewController *)self.viewController refreshListTableView];
        }];
    }
    return _noServiceView;
}

- (UIView *)noDataDisplayView
{
    if (!_noDataDisplayView) {
        _noDataDisplayView = [self noDataDisplayViewWithInfoImageName:@"only_hangzhou" clickString:@"看一看" moreMessage:@"" clickBlock:^{
            NSLog(@"联系有个空间了解更多:yingxiang@yinglai.ren");
            
            [[WSFSpaceListMapManager shareManager] resetScreenCityCondition];
            //标题View
            NSLog(@"[WSFSpaceListMapManager shareManager].selectedCityName~~%@",[WSFSpaceListMapManager shareManager].selectedCityName);
            WSFButton *titleBtn = (WSFButton *)self.viewController.navigationItem.titleView;
            [titleBtn setTitle:[WSFSpaceListMapManager shareManager].selectedCityName forState:UIControlStateNormal];
            
            [(SpaceListViewController *)self.viewController refreshListTableView];
        }];
    }
    return _noDataDisplayView;
}

- (UIView *)noDataDisplayViewWithInfoImageName:(NSString *)imageName clickString:(NSString *)clickString moreMessage:(NSString *)moreMessage clickBlock:(void(^)())block
{
    UIView *showMessageView = [[UIView alloc]initWithFrame:self.bounds];
    showMessageView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    
    //1.添加图片
    UIImageView *notFoundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    UIImage *failImage = [UIImage imageNamed:imageName];
    notFoundImageView.width = failImage.size.width;
    notFoundImageView.height = failImage.size.height;
    notFoundImageView.top = (self.size.height - failImage.size.height)/2.f - 64;
    notFoundImageView.image = failImage;
    CGPoint center = notFoundImageView.center;
    center.x = showMessageView.center.x;
    notFoundImageView.center = center;
    [showMessageView addSubview:notFoundImageView];
    
    //2.添加按钮
    //底色
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor clearColor];
    [showMessageView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(notFoundImageView.mas_bottom).offset(45);
        make.centerX.equalTo(showMessageView);
        make.size.mas_equalTo(CGSizeMake(100, 35));
    }];
    //按钮
    if (clickString) {
        HSBlockButton *clickBtn = [HSBlockButton buttonWithType:UIButtonTypeCustom];
        [clickBtn setBackgroundImage:[UIImage imageNamed:@"tuoyuan_blue"] forState:UIControlStateNormal];
        [clickBtn setTitle:clickString forState:UIControlStateNormal];
        [clickBtn setTitleColor:[UIColor colorWithHexString:@"2b84c6"] forState:UIControlStateNormal];
        [clickBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bottomView addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomView);
            make.centerX.equalTo(bottomView);
            make.size.mas_equalTo(CGSizeMake(100, 35));
        }];
        [clickBtn addTouchUpInsideBlock:^(UIButton *button) {
            
            [showMessageView removeFromSuperview];
            block();
        }];
    }
    
    // 3.底部的更多信息
    UILabel *moreMessageLabel = [[UILabel alloc] init];
    moreMessageLabel.text = moreMessage;
    moreMessageLabel.textColor = [UIColor lightGrayColor];
    moreMessageLabel.font = [UIFont systemFontOfSize:12];
    [showMessageView addSubview:moreMessageLabel];
    [moreMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(showMessageView.mas_centerX).offset(0);
        make.bottom.mas_equalTo(showMessageView.mas_bottom).offset(-20);
    }];
    
    // 4.
    return showMessageView;
}

@end
