//
//  WSFHomePageHotCView.m
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageHotCView.h"
#import "WSFHomePageCItem.h"
#import "SpaceDetailViewController.h"
#import "WSFFieldDetailVC.h"

@interface WSFHomePageHotCView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end


@implementation WSFHomePageHotCView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[WSFHomePageCItem class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

-(void)setHotRoomArray:(NSMutableArray<WSFHomePageHotRoomVM *> *)hotRoomArray {
    _hotRoomArray = hotRoomArray;
    [self reloadData];
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotRoomArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(124, self.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第 %zd组 第%zd个",indexPath.section, indexPath.row);
    WSFHomePageHotRoomVM *hotRoomVM = _hotRoomArray[indexPath.row];
    if (hotRoomVM.typeOfRoomKey == 1) {
        //小包厢
        SpaceDetailViewController *spaceDetailVC = [[SpaceDetailViewController alloc] init];
        spaceDetailVC.SpaceId = hotRoomVM.roomId;
        [self.viewController.navigationController pushViewController:spaceDetailVC animated:NO];
    }else {
        //大场地
        WSFFieldDetailVC *detailVC = [[WSFFieldDetailVC alloc]init];
        detailVC.roomId = hotRoomVM.roomId;
        [self.viewController.navigationController pushViewController:detailVC animated:NO];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WSFHomePageCItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WSFHomePageHotRoomVM *hotRoomVM = _hotRoomArray[indexPath.row];
    cell.hotRoomVM = hotRoomVM;
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
