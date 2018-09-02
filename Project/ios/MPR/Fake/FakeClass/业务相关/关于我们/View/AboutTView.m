//
//  AboutTView.m
//  WinShare
//
//  Created by GZH on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "AboutTView.h"

@interface AboutTView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *messageArray;
@end

@implementation AboutTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setAppPlatformPhoneNumber:(NSString *)appPlatformPhoneNumber
{
    _appPlatformPhoneNumber = appPlatformPhoneNumber;
    [self reloadData];
}

#pragma mark - tableViewDataSource,UITableViewDelegate

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AboutDefaultCell1"];
//        cell.textLabel.text = [self.messageArray objectAtIndex:indexPath.row];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
//        lineView.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
//        [cell.contentView addSubview:lineView];
//
//        return cell;
//    }else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AboutDefaultCell2"];
        cell.textLabel.text = [self.messageArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = self.appPlatformPhoneNumber;
        [cell.detailTextLabel setTextColor:[UIColor colorWithHexString:@"#2b84c6"]];
        
        //拨打电话
        UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        callBtn.eventTimeInterval = 1;
        [callBtn addTarget:self action:@selector(callPhoneAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:callBtn];
        [callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
        [cell.contentView addSubview:lineView];
        
        return cell;
    }

    return nil;
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//当已经点击cell时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:{
            

            break;
        }
            
        case 1:{
            
            break;
        }
            
    }
}

/**  打电话-- 联系商家 */
- (void)callPhoneAction
{
    [HSMathod callPhoneWithNumber:self.appPlatformPhoneNumber];
}


#pragma mark - lazyLoad

- (NSArray *)messageArray
{
    if (!_messageArray) {
        _messageArray = @[@"联系我们"];
    }
    return _messageArray;
}

@end
