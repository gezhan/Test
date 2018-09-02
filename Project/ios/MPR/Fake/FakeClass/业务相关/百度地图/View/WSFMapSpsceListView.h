//
//  WSFMapSpsceListView.h
//  WinShare
//
//  Created by GZH on 2017/11/16.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpaceMessageModel;

typedef void(^TouchBlock)();

@interface WSFMapSpsceListView : UIView
/**  点击黑色蒙版时候的回调 */
@property (nonatomic, copy) TouchBlock touchBlock;

/**  数据源 */
@property (nonatomic, strong) NSMutableArray<SpaceMessageModel *> *dataArray;

/**  当前控制器 */
@property (nonatomic, strong) UIViewController *currentVC;

/**  将collectionView展示出来 */
- (void)showCollectionView;

@end
