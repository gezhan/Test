//
//  WSFNavigationView.h
//  WinShare
//
//  Created by QIjikj on 2017/12/6.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WSFNavigationViewDelegate <NSObject>
@optional
- (void)navigationBarButtonLeftAction;
- (void)navigationBarButtonRightAction;
@end

@interface WSFNavigationView : UIView

@property (nonatomic, assign) id <WSFNavigationViewDelegate> delegate;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, copy) NSString *leftBackgroundImage;
@property (nonatomic, copy) NSString *rightBackgroundImage;

@end
