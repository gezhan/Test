//
//  WSFShareView.m
//  WinShare
//
//  Created by devRen on 2017/11/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFShareView.h"
#import <UMSocialCore/UMSocialCore.h>

static NSTimeInterval const WSFShareViewAnimationTime = 0.35;   // 弹出 view 的动画时间
static CGFloat const WSFShareViewHeightNormal = 150;            // 默认的弹窗高度
static CGFloat const WSFShareViewHeightReminder = 187;          // 带提示信息的弹窗高度
static NSUInteger const WSFShareEachRowVarietyCount = 4;        // 每行分享种类数量

RYJKIT_STATIC_INLINE NSArray *getShareVarietyArray() {
    static NSArray *shareVarietyArray = nil;
    if (!shareVarietyArray) {
        shareVarietyArray = @[
//                              @{@"微信好友":@"weixinyou"},
//                              @{@"朋友圈":@"pengyouquan"},
                               @{@"":@""},
                              @{@"QQ":@"qq"},
                              @{@"QQ空间":@"qqkongjian"}];
    }
    return shareVarietyArray;
}

RYJKIT_STATIC_INLINE CGFloat getBGViewHeight(WSFShareViewType shareViewType) {
    NSInteger height = 75 * ((getShareVarietyArray().count - 1) / WSFShareEachRowVarietyCount);
    switch (shareViewType) {
        case WSFShareViewType_Normal:
            return WSFShareViewHeightNormal + height;
            break;
        case WSFShareViewType_Reminder:
            return WSFShareViewHeightReminder + height;
            break;
    }
}

@implementation WSFShareMessageModel

@end

@interface WSFShareView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) WSFShareMessageModel *shareMessageModel;

@end

@implementation WSFShareView

+ (void)showWithShareMessageModel:(WSFShareMessageModel *)shareMessageModel {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wunused-variable"
    WSFShareView *view = [[WSFShareView alloc] initWithShareMessageModel:shareMessageModel];
    #pragma clang diagnostic pop
}

- (instancetype)initWithShareMessageModel:(WSFShareMessageModel *)shareMessageModel {
    self = [super init];
    if (self) {
        self.frame = SCREEN_BOUNDS;
        [kAppWindow addSubview:self];
        self.backgroundColor = RGBA(0, 0, 0, 0);
        _shareMessageModel = shareMessageModel;
        [self layoutUI];
        [self ryj_showPickView];
    }
    return self;
}

#pragma mark - 布局UI
- (void)layoutUI {
    if (_shareMessageModel.shareViewType == WSFShareViewType_Reminder) {
        // 文字
        UILabel *lable = [[UILabel alloc] init];
        lable.text = _shareMessageModel.shareReminder;
        lable.font = SYSTEMFONT_14;
        lable.textColor = HEX_COLOR_0x333333;
        lable.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(self.bgView.mas_top).mas_offset(20);
        }];
    }

    // 分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blackColor];
    [self.bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.height.equalTo(@0.5);
        make.top.equalTo(self.bgView.mas_bottom).mas_offset(-50);
    }];
    
    // 取消按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.titleLabel.font = SYSTEMFONT_16;
    [btn setTitleColor:HEX_COLOR_0x333333 forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ryj_hidePickView) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.height.equalTo(@50);
        make.top.equalTo(line.mas_bottom);
    }];
    
    NSInteger gapW = (SCREEN_WIDTH - 160) / (WSFShareEachRowVarietyCount + 1);
    NSArray *varietyArray = getShareVarietyArray();
    for (NSInteger i = 0; i < getShareVarietyArray().count; i ++) {
        UIButton *button = [self ryj_factoryButtonWithImageName:[[varietyArray[i] allValues] firstObject] text:[[varietyArray[i] allKeys] firstObject]];
        [button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(gapW * (i % WSFShareEachRowVarietyCount + 1) + 40 * (i % WSFShareEachRowVarietyCount));
            NSInteger height = -75 *((varietyArray.count - 1) / WSFShareEachRowVarietyCount - (i / WSFShareEachRowVarietyCount));
            make.bottom.mas_equalTo(line.mas_top).offset(-15 + height);
            make.size.mas_equalTo(CGSizeMake(40, 60));
        }];
    }
}

#pragma mark - 私有方法
- (void)ryj_showPickView {
    [UIView animateWithDuration:WSFShareViewAnimationTime animations:^{
        self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT - getBGViewHeight(_shareMessageModel.shareViewType), SCREEN_WIDTH, getBGViewHeight(_shareMessageModel.shareViewType));
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
    } completion:nil];
}

- (void)ryj_hidePickView {
    [UIView animateWithDuration:WSFShareViewAnimationTime animations:^{
        self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, getBGViewHeight(_shareMessageModel.shareViewType));
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIButton *)ryj_factoryButtonWithImageName:(NSString *)imageName text:(NSString *)text {
    UIButton *btnObj = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnObj setTitle:text forState:UIControlStateNormal];
    [btnObj.titleLabel setFont:SYSTEMFONT_10];
    [btnObj setTitleColor:HEX_COLOR_0x1A1A1A forState:UIControlStateNormal];
    [btnObj setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btnObj.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnObj.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    btnObj.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    btnObj.titleEdgeInsets = UIEdgeInsetsMake(48, -40 + (40 - [HSMathod getSizeForText:text fontSize:10].width)/2.0, 0, -9);
    return btnObj;
}

#pragma mark - 点击事件
- (void)shareAction:(UIButton *)btn {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_shareMessageModel.shareTitle descr:_shareMessageModel.shareDescr thumImage:_shareMessageModel.shareThumImage];
    //设置网页地址
    shareObject.webpageUrl = _shareMessageModel.shareURL;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    // 调用分享接口
    UMSocialPlatformType selectedPlatform = UMSocialPlatformType_UnKnown;
    if ([btn.titleLabel.text isEqualToString:@"微信好友"]) {
        selectedPlatform = UMSocialPlatformType_WechatSession;
    }else if ([btn.titleLabel.text isEqualToString:@"朋友圈"]) {
        selectedPlatform = UMSocialPlatformType_WechatTimeLine;
    }else if ([btn.titleLabel.text isEqualToString:@"QQ"]) {
        selectedPlatform = UMSocialPlatformType_QQ;
    }else if ([btn.titleLabel.text isEqualToString:@"QQ空间"]) {
        selectedPlatform = UMSocialPlatformType_Qzone;
    }else {
        
    }
    [[UMSocialManager defaultManager] shareToPlatform:selectedPlatform messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            if (error.code == 2008) {
                if (selectedPlatform == UMSocialPlatformType_WechatSession || selectedPlatform == UMSocialPlatformType_WechatTimeLine) {
                    [MBProgressHUD showMessage:@"请先安装微信"];
                }else if (selectedPlatform == UMSocialPlatformType_QQ || selectedPlatform == UMSocialPlatformType_Qzone) {
                    [MBProgressHUD showMessage:@"请先安装腾讯QQ"];
                }else {
                    [MBProgressHUD showMessage:@"请先安装相关应用"];
                }
            }
            
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self ryj_hidePickView];
    }
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, getBGViewHeight(_shareMessageModel.shareViewType))];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
    }
    return _bgView;
}

@end
