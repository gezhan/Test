//
//  WSFHomePageHotCView.h
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSFHomePageVM.h"

@interface WSFHomePageHotCView : UICollectionView

@property (nonatomic, strong) NSMutableArray<WSFHomePageHotRoomVM*> *hotRoomArray;

@end
