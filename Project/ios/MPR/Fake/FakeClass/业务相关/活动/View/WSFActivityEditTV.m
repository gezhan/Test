//
//  WSFActivityEditTV.m
//  WinShare
//
//  Created by GZH on 2018/2/27.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityEditTV.h"
#import "WSFActivityEditTVCell.h"
@interface WSFActivityEditTV() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *lineLabel;

@end
@implementation WSFActivityEditTV

- (UILabel *)lineLabel {
    if (_lineLabel == nil) {
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _lineLabel.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    }
    return _lineLabel;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 50;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

#pragma mark - Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return 3;
    if(section == 1) return 6;
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"cell%ld%ld", (long)indexPath.section, (long)indexPath.row];
    WSFActivityEditTVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[WSFActivityEditTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
   if (indexPath.row != 0) {
        [cell.contentView addSubview:self.lineLabel];
    }
    cell.tag = indexPath.section * 10 + indexPath.row;

    return cell;
}

- (void)getActivityName {
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    WSFActivityEditTVCell *cell = [self cellForRowAtIndexPath:index];
    NSIndexPath *index1 = [NSIndexPath indexPathForRow:2 inSection:0];
    WSFActivityEditTVCell *cell1 = [self cellForRowAtIndexPath:index1];
    NSLog(@"-----------------------------------------%@-----%@", cell.textField.text, cell1.textField.text);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
