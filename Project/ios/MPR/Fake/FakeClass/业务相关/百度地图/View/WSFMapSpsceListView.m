//
//  WSFMapSpsceListView.m
//  WinShare
//
//  Created by GZH on 2017/11/16.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFMapSpsceListView.h"
#import "WSFMapBottomCell.h"
#import "SpaceDetailViewController.h"
#import "SpaceMessageModel.h"

@interface WSFMapSpsceListView ()<UICollectionViewDelegate, UICollectionViewDataSource>
/**  半透明的View */
@property (nonatomic, strong) UIView *coverView;
/**  底部的view */
@property (nonatomic, strong) UIView *backView;
/**  可滑动的collectionView */
@property (nonatomic, strong) UICollectionView *listCollectionView;
/**  会议室个数 */
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation WSFMapSpsceListView

- (void)showCollectionView {
    self.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        _backView.frame = CGRectMake(0, SCREEN_HEIGHT - 188, SCREEN_WIDTH, 188);
    }];
}

- (void)setDataArray:(NSMutableArray<SpaceMessageModel *> *)dataArray {
    _dataArray = dataArray;
    _numberLabel.text = [NSString stringWithFormat:@"%ld个会议室", (unsigned long)dataArray.count];
    [_numberLabel sizeToFit];
    [_listCollectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupViewContent];
        
    }
    return self;
}

- (void)setupViewContent {
    self.frame = SCREEN_BOUNDS;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.4;
    [kAppWindow addSubview:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverBackAction)];
    [self addGestureRecognizer:tap];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 188)];
    backView.backgroundColor = [UIColor whiteColor];
    _backView = backView;
    [kAppWindow addSubview:backView];
    
    UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, SCREEN_WIDTH - 20, 0)];
    numberLabel.text = @"2个会议室";
    numberLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    numberLabel.font = [UIFont systemFontOfSize:12];
    _numberLabel = numberLabel;
    [numberLabel sizeToFit];
    [backView addSubview:numberLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(160, 188 - numberLabel.height - 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 15;
    _listCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, numberLabel.bottom + 10, SCREEN_WIDTH - 20, 188 - numberLabel.height - 10) collectionViewLayout:layout];
    _listCollectionView.delegate = self;
    _listCollectionView.dataSource = self;
    _listCollectionView.showsVerticalScrollIndicator = NO;
    _listCollectionView.showsHorizontalScrollIndicator = NO;
    [_listCollectionView registerClass:[WSFMapBottomCell class] forCellWithReuseIdentifier:@"cell"];
    _listCollectionView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:_listCollectionView];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self coverBackAction];
    SpaceMessageModel *spaceModel = _dataArray[indexPath.row];
    SpaceDetailViewController *vc = [[SpaceDetailViewController alloc] init];
    vc.SpaceId = spaceModel.spaceId;
    [self.currentVC.navigationController pushViewController:vc animated:NO];
    [self coverBackAction];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WSFMapBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (_dataArray.count > 0) {
        SpaceMessageModel *model = _dataArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

- (void)coverBackAction {
    self.hidden = YES;
    [UIView animateWithDuration:0.35 animations:^{
        _backView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 188);
    }];
    if(_touchBlock)_touchBlock();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
