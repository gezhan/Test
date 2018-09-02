//
//  WSFActivityPostersTV.m
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityPostersTV.h"
#import "WSFActivityPostersTVCell.h"
@interface WSFActivityPostersTV() <UITableViewDelegate, UITableViewDataSource>

@end
@implementation WSFActivityPostersTV

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

- (void)setPhotoArray:(NSArray<UIImage *> *)photoArray {
    _photoArray = photoArray;
    [self reloadData];
}

#pragma mark - Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _photoArray.count;
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
    WSFActivityPostersTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[WSFActivityPostersTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (_photoArray.count > 0) {
        cell.photo.image = _photoArray[indexPath.row];
        cell.deleteBtn.tag = indexPath.row + 666;
        [cell.deleteBtn addTarget:self action:@selector(deletePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

/**  删除照片 */
- (void)deletePhotoAction:(UIButton *)sender {
    NSInteger indexRow = sender.tag - 666;
    NSLog(@"------删除--%ld", (long)indexRow);
    if (_photoBlock) {
        _photoBlock(indexRow);
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
