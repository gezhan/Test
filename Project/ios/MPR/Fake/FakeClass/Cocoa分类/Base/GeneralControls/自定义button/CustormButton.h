//
//  CustormButton.h
//  WinShare
//
//  Created by GZH on 2017/5/17.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustormButton : UIButton

//创建button的时候自适应上边的文字和图片-->左文字，右图片
-(void)creatCusbtnImg:(NSString *)imgName WithTitle:(NSString *)title;


//重新赋值的时候再次自适应
- (void)layoutAgainWithNewTitle:(NSString *)newTitle;


@end
