//
//  ChoosePeopleCountview.h
//  WinShare
//
//  Created by GZH on 2017/5/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PeopleCountBlock)(NSArray *);

@interface ChoosePeopleCountview : UICollectionView

@property (nonatomic, copy) NSNumber *currentMinPeople; //选中的人数区间-->较小的值

@property (nonatomic, copy) PeopleCountBlock peopleCountBlock;


@property (nonatomic, assign) NSInteger index;  //选中的item的下标

@end
