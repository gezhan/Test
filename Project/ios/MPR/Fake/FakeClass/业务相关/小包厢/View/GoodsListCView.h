//
//  GoodsListCView.h
//  WinShare
//
//  Created by QIjikj on 2017/5/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpaceGoodsModel;

@interface GoodsListCView : UICollectionView

@property (nonatomic, strong) NSArray <SpaceGoodsModel *> *SpaceGoodsArray;

@end
