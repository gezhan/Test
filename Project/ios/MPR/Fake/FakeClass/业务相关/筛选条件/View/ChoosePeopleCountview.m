//
//  ChoosePeopleCountview.m
//  WinShare
//
//  Created by GZH on 2017/5/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ChoosePeopleCountview.h"
#import "ChoosePeopleItem.h"

@interface ChoosePeopleCountview ()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (nonatomic, strong) NSArray *minCountArray;
@property (nonatomic, strong) NSArray *dataArray;  //显示的数据
@property (nonatomic, strong) NSMutableArray *buttonArray;   //所有button的数组
@property (nonatomic, strong) NSMutableArray *array;  //回调的数据



@end

@implementation ChoosePeopleCountview

- (void)setCurrentMinPeople:(NSNumber *)currentMinPeople {
    _currentMinPeople = currentMinPeople;
    //选中状态的设置
    if (currentMinPeople != NULL && ![currentMinPeople isEqual:@0]) {
        for (int i = 0; i < _minCountArray.count; i++) {
            NSNumber *tempNum = [NSNumber numberWithInt:[_minCountArray[i] intValue]];
            if ([tempNum isEqualToNumber:currentMinPeople]) {
                
                _index = i;
                break;
            }
        }
    }else {
        _index = 0;
    }
    if (_index > 3) {
        self.contentOffset= CGPointMake(125, 0);
    }else {
         self.contentOffset= CGPointMake(0, 0);
    }
    
    [self reloadData];
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        _minCountArray = @[@"0", @"1", @"5",@"10",@"15",@"20"];
        _dataArray = @[@"不限",@"1-5人",@"5-10人",@"10-15人",@"15-20人",@"20人以上"];
        _buttonArray = [NSMutableArray array];
        _array = [NSMutableArray array];
        
        
        self.delegate = self;
        self.dataSource = self;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[ChoosePeopleItem class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChoosePeopleItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    

    if (indexPath.row == _index) {
        cell.button.selected = YES;
    }else {
        cell.button.selected = NO;
    }
    [cell.button setTitle:_dataArray[indexPath.row] forState:UIControlStateNormal];
    [cell.button addTarget:self action:@selector(changePeopleCountAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (![_buttonArray containsObject:cell.button]) {
        [_buttonArray addObject:cell.button];
    }
    
    
    return cell;
}


- (void)changePeopleCountAction:(UIButton *)sender {
    for (UIButton *tempBtn in _buttonArray) {
        tempBtn.selected = NO;
    }
    sender.selected = YES;
    
    
    
    [_array removeAllObjects];
    NSString *countPeo = sender.titleLabel.text;
    
    //20人以上
    if ([countPeo containsString:@"以上"]) {
        
        [ _array addObject:[NSNumber numberWithInt:20]];
        [_array addObject:[NSNumber numberWithInt:1000]];
        
        if(_peopleCountBlock)_peopleCountBlock(_array.copy);
        
    }else {
        
        //不限人数
        if ([countPeo isEqualToString:@"不限"]) {
            [ _array addObject:[NSNumber numberWithInt:0]];
            [_array addObject:[NSNumber numberWithInt:0]];
            if(_peopleCountBlock)_peopleCountBlock(_array.copy);
            
        }else {
            
            //选择项中有的人数
            countPeo = [countPeo stringByReplacingOccurrencesOfString:@"人" withString:@""];
            NSRange range = [countPeo rangeOfString:@"-"];
            NSString *result1 = [countPeo substringToIndex:range.location];
            NSString *result2 = [countPeo substringFromIndex:range.location + 1];
            [_array addObject:@([result1 integerValue])];
            [_array addObject:@([result2 integerValue])];
            
            if(_peopleCountBlock)_peopleCountBlock(_array.copy);
            
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
