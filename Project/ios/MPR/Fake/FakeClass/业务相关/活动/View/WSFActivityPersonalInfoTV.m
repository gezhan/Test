//
//  WSFActivityPersonalInfoTV.m
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityPersonalInfoTV.h"
#import "WSFActivityPersonalInfoCell.h"
@interface WSFActivityPersonalInfoTV() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WSFActivityPersonalInfoTV


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return self;
}

#pragma mark - Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSFActivityPersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[WSFActivityPersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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
