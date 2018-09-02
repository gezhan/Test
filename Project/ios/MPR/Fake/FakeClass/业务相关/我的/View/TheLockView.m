//
//  TheLockView.m
//  WinShare
//
//  Created by GZH on 2017/5/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TheLockView.h"
#import "RoomCell.h"
#import "PasswordModel.h"

@interface TheLockView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)  UITableView *tableView;

@end

@implementation TheLockView

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;

    //有预定的房间
    if (self.dataSource.count != 0) {
        
        //小于两个预定不可以滑动
        if (_dataSource.count <= 2) {
            self.tableView.scrollEnabled = NO;
        }
        [self.tableView reloadData];
    }else {
        

        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"您还没有预定的空间";
        label.textColor = [UIColor colorWithHexString:@"#808080"];
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            
        }];
    }
   
}

- (UITableView *)tableView {
    if (_tableView == nil) {

        self.tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        //设置分割线的风格
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        /** 去除tableview 右侧滚动条 */
        _tableView.showsVerticalScrollIndicator = YES;
 
        
        //设置分割线距边界的距离
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 10.0;
        
        
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];

        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 141;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[RoomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (self.dataSource.count > 0) {
        PasswordModel *model = self.dataSource[indexPath.row];
        cell.model = model;
    }
    
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
