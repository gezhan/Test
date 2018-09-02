//
//  CustormButton.m
//  WinShare
//
//  Created by GZH on 2017/5/17.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "CustormButton.h"

@interface CustormButton (){
    UIImageView * _imgView;
    UILabel * _titLa;
}


@end

@implementation CustormButton

- (void)creatCusbtnImg:(NSString *)imgName WithTitle:(NSString *)title {
    
//    __weak typeof(self)weakSelf = self;
    
    _imgView=[UIImageView new];
    [self addSubview:_imgView];
    
    _titLa=[UILabel new];
    _titLa.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _titLa.text = title;
    _titLa.textAlignment = NSTextAlignmentCenter;
    _titLa.font = [UIFont systemFontOfSize:12];
    [self addSubview:_titLa];
    
    CGRect rect = [_titLa getFrameWithFreeWidth:CGPointMake(0, 0) maxHight:self.height];
    _titLa.frame = CGRectMake( (self.width - rect.size.width-_imgView.width - 5)/2 , 0, rect.size.width, self.height);
    _imgView.frame = CGRectMake(_titLa.right + 5, (self.height - 6)/2, 10, 6);
    _imgView.image = [UIImage imageNamed:imgName];
        
}

- (void)layoutAgainWithNewTitle:(NSString *)newTitle {
    
    _titLa.text = newTitle;
    CGRect rect = [_titLa getFrameWithFreeWidth:CGPointMake(0, 0) maxHight:self.height];
    _titLa.frame = CGRectMake( (self.width - rect.size.width-_imgView.width - 5)/2 , 0, rect.size.width, self.height);
    _imgView.frame = CGRectMake(_titLa.right + 5, (self.height - 6)/2, 10, 6);

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
