//
//  UITableView+ShowMessageView.m
//  WinShare
//
//  Created by GZH on 2017/5/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UITableView+ShowMessageView.h"
#import "HSBlockButton.h"

@implementation UITableView (ShowMessageView)

- (void)tableViewDisplayNotFoundViewWithRowCount:(NSInteger)rowCount withImageName:(NSString *)imageName
{
    if (rowCount == 0) {
        UIView *showMessageView = [[UIView alloc]initWithFrame:self.bounds];
        showMessageView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];

        //添加图片
        UIImageView *notFoundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *failImage = [UIImage imageNamed:imageName];
        notFoundImageView.width = failImage.size.width;
        notFoundImageView.height = failImage.size.height;
        notFoundImageView.top = (self.size.height - failImage.size.height)/2.f - 64;
        notFoundImageView.image = failImage;
        CGPoint center = notFoundImageView.center;
        center.x = showMessageView.center.x;
        notFoundImageView.center = center;
        [showMessageView addSubview:notFoundImageView];
        self.backgroundView = showMessageView;
    }else{
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)tableViewDisplayNotFoundViewWithNetworkLoss:(BOOL)networkLoss withImageName:(NSString *)imageName clickString:(NSString *)clickString clickBlock:(void(^)())block
{
    if (networkLoss) {
        UIView *showMessageView = [[UIView alloc]initWithFrame:self.bounds];
        showMessageView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        
        //添加图片
        UIImageView *notFoundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *failImage = [UIImage imageNamed:imageName];
        notFoundImageView.width = failImage.size.width;
        notFoundImageView.height = failImage.size.height;
        notFoundImageView.top = (self.size.height - failImage.size.height)/2.f - 64;
        notFoundImageView.image = failImage;
        CGPoint center = notFoundImageView.center;
        center.x = showMessageView.center.x;
        notFoundImageView.center = center;
        [showMessageView addSubview:notFoundImageView];
        
        //添加按钮
        //白色的底色
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor whiteColor];
        [showMessageView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(notFoundImageView.mas_bottom).offset(45);
            make.centerX.equalTo(showMessageView);
            make.size.mas_equalTo(CGSizeMake(100, 35));
        }];
        //按钮
        HSBlockButton *clickBtn = [HSBlockButton buttonWithType:UIButtonTypeCustom];
        [clickBtn setBackgroundImage:[UIImage imageNamed:@"tuoyuan_black"] forState:UIControlStateNormal];
        [clickBtn setTitle:clickString forState:UIControlStateNormal];
        [clickBtn setTitleColor:[UIColor colorWithHexString:@"2b84c6"] forState:UIControlStateNormal];
        [clickBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bottomView addSubview:clickBtn];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomView);
            make.centerX.equalTo(bottomView);
            make.size.mas_equalTo(CGSizeMake(100, 35));
        }];
        [clickBtn addTouchUpInsideBlock:^(UIButton *button) {
            
            self.backgroundView = nil;
            self.separatorStyle = UITableViewCellSeparatorStyleNone;
            block();
        }];
        
        self.backgroundView = showMessageView;
    }else{
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

@end
