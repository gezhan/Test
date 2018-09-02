//
//  WSFFieldTimeTV.m
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldTimeTV.h"
#import "WSFFieldTimeTVCell.h"
#import "WSFFieldSelectedVM.h"
#import "WSFFieldDetailM.h"

@interface WSFFieldTimeTV() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) WSFFieldSelectedVM *playgroundVM;
@end
@implementation WSFFieldTimeTV

- (instancetype)initWithPlaygroundSelectedVM:(WSFFieldSelectedVM *)selectedVM {
    self = [super init];
    if (self) {
        
        _playgroundVM = selectedVM;
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.allowsSelection = NO;
    }
    return self;
}

- (void)setDetailModel:(WSFFieldDetailM *)detailModel {
    _detailModel = detailModel;
}

#pragma mark - Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _playgroundVM.dataSource.count;
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
    NSString *identifier = [NSString stringWithFormat:@"cell%ld%ld", (long)indexPath.section, (long)indexPath.row];
    WSFFieldTimeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[WSFFieldTimeTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        WSFFieldSelectedCellVM *selectedCellVM = _playgroundVM.dataSource[indexPath.row];
        cell.selectedCellVM = selectedCellVM;
        cell.detailModel = _detailModel;
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
