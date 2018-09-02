//
//  WSFCityTableView.m
//  WinShare
//
//  Created by GZH on 2017/12/19.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFCityTableView.h"
#import "WSFCityViewModel.h"
#import "WSFCityTableViewCell.h"

@interface WSFCityTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation WSFCityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = UITableViewAutomaticDimension;
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        self.sectionIndexColor = [UIColor colorWithHexString:@"#808080"];
        
    }
    return self;
}

- (void)setViewModel:(WSFCityViewModel *)viewModel {
    _viewModel = viewModel;
    [self reloadData];
}

- (void)setPlacemark:(CLPlacemark *)placemark {
    _placemark = placemark;
//    [self reloadData];
}

#pragma mark - tableViewDataSource,UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 1) {
        WSFCityDetailModel *detailModel = _viewModel.cityArray[indexPath.section-2][indexPath.row];
        if(_cityNameBlack)_cityNameBlack(detailModel.regionName);
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _viewModel.firstSpellArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _viewModel.firstSpellArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0 || section == 1) return 1;
    NSArray *array = _viewModel.cityArray[section - 2];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section <= 1) {
        WSFCityTableViewCell *hotCityCell = [tableView dequeueReusableCellWithIdentifier:@"hotCityCell"];
        if (hotCityCell == nil) {
            hotCityCell = [[WSFCityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotCityCell"];
            hotCityCell.tag = indexPath.section + 1024;
        }
        if(_placemark.locality.length > 0) hotCityCell.placemark = _placemark;
        hotCityCell.cityNameBlack = ^(NSString *cityName) {
            if(_cityNameBlack)_cityNameBlack(cityName);
        };
        return hotCityCell;
    }else {
      NSString *cellidentifier = [NSString stringWithFormat:@"cell%ld", (long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row != 0) {
            UILabel *lineLabel = [[UILabel alloc]init];
            lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
            [cell.contentView addSubview:lineLabel];
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(cell.contentView);
                make.top.equalTo(cell.contentView.mas_top);
                make.height.equalTo(@0.5);
            }];
        }
        if (indexPath.section > 1) {
            WSFCityDetailModel *detailModel = _viewModel.cityArray[indexPath.section - 2][indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@", detailModel.regionName];
        }
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    sectionHeaderView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 20, 12)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHexString:@"#808080"];
    label.textAlignment = NSTextAlignmentLeft;
    if (_viewModel.firstSpellArray.count > 0) {
        label.text = _viewModel.firstSpellArray[section];
        [label sizeToFit];
    }
    [sectionHeaderView addSubview:label];
    return sectionHeaderView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) return 0;
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0) return 80;
    if(indexPath.section == 1) return 101;
    return 49;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
