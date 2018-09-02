//
//  WSFActivityListVM.m
//  WinShare
//
//  Created by GZH on 2018/3/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityListVM.h"
#import "WSFRPAppEventSearchQueryResModel.h"
#import "WSFRPAppEventSearchResModel.h"
#import "NSMutableAttributedString+WSFExtend.h"

@implementation WSFActivityListCellVM

@end


@implementation WSFActivityListVM

- (void)refershActivityTModel:(WSFRPAppEventSearchQueryResModel *)resModel {
    if(self.dataSource.count > 0)[self.dataSource removeAllObjects];
    for (int i = 0; i < resModel.records.count; i++) {
        WSFRPAppEventSearchResModel *tempModel = resModel.records[i];
        [self dataSourceWithModel:tempModel];
    }
}

- (void)addActivityTModel:(WSFRPAppEventSearchQueryResModel *)resModel{
    for (int i = 0; i < resModel.records.count; i++) {
        WSFRPAppEventSearchResModel *tempModel = resModel.records[i];
        [self dataSourceWithModel:tempModel];
    }
}

- (void)dataSourceWithModel:(WSFRPAppEventSearchResModel *) tempModel {
    WSFActivityListCellVM *model = [[WSFActivityListCellVM alloc]init];
    model.Id = tempModel.Id;
    model.picture = [NSString replaceString:tempModel.picture.path];
    model.name = tempModel.name;
    NSMutableAttributedString *attributedText  = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ \n %@", tempModel.eventTheTime, tempModel.address]];
    [attributedText wsf_setLineSpace:4 range:NSMakeRange(0, attributedText.length)];
    model.timeAndAddress = attributedText;
    model.eventStatus = tempModel.eventStatus.value;
    model.enrolmentFee = tempModel.enrolmentFee;
    model.man = tempModel.man;
    [self.dataSource addObject:model];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



@end
