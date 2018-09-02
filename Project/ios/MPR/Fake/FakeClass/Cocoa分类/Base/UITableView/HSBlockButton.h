//
//  UIView+ViewFrameGeometry.h
//  WinShare
//
//  Created by Gzh on 2017/4/30.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlock)(UIButton *button);

@interface HSBlockButton : UIButton

@property(nonatomic, copy) ButtonBlock block;

/*UIControlEventTouchUpInside*/
- (void)addTouchUpInsideBlock:(ButtonBlock)block;

@end
