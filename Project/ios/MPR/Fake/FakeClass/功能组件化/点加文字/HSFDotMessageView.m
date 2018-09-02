//
//  HSFDotMessageView.m
//  WinShare
//
//  Created by QIjikj on 2017/10/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#define kDotY ((HeightForFontSize(self.contentFont) / 2) + (self.dotSize.height / 2) - 2)

#import "HSFDotMessageView.h"

@interface HSFDotMessageView ()

@property (nonatomic, strong) NSArray *titleArray;// 标题文字数组
@property (nonatomic, assign) NSInteger titleFont;// 标题文字字号
@property (nonatomic, strong) UIColor *titleColor;// 标题文字颜色

@property (nonatomic, strong) NSArray *contentArray;// 内容文字数组
@property (nonatomic, assign) NSInteger contentFont;// 内容文字字号
@property (nonatomic, strong) UIColor *contentColor;// 内容文字颜色

@property (nonatomic, assign) CGSize dotSize;// 点的大小
@property (nonatomic, strong) UIColor *dotColor;// 点的颜色

@property (nonatomic, assign) NSInteger groupHeight;// 每组内容的行间距离

@end

@implementation HSFDotMessageView

#pragma mark - 标题点+内容文字
- (instancetype)initWithContentArray:(NSArray<NSString *> *)contentArr contentFont:(NSInteger)contentFont contentColor:(UIColor *)contentColor dotSize:(CGSize)dotSize dotColor:(UIColor *)dotColor groupHeight:(NSInteger)groupHeight
{
    if (self = [super init]) {
        
        self.contentArray = contentArr;
        self.contentFont = contentFont;
        self.contentColor = contentColor;
        self.dotSize = dotSize;
        self.dotColor = dotColor;
        self.groupHeight = groupHeight;
        
        [self setupViewContent];
    }
    return self;
}

- (void)resetContentArray:(NSArray <NSString *>*)contentArr contentFont:(NSInteger)contentFont contentColor:(UIColor *)contentColor dotSize:(CGSize)dotSize dotColor:(UIColor *)dotColor groupHeight:(NSInteger)groupHeight
{
    self.contentArray = contentArr;
    self.contentFont = contentFont;
    self.contentColor = contentColor;
    self.dotSize = dotSize;
    self.dotColor = dotColor;
    self.groupHeight = groupHeight;
    
    NSArray *subViewArr = self.subviews;
    for (UIView *tempView in subViewArr) {
        [tempView removeFromSuperview];
    }
    
    [self setupViewContent];
}

- (void)resetContentArray:(NSArray <NSString *>*)contentArr
{
    [self resetContentArray:contentArr contentFont:self.contentFont contentColor:self.contentColor dotSize:self.dotSize dotColor:self.dotColor groupHeight:self.groupHeight];
}

#pragma mark - 标题文字+内容文字
- (instancetype)initWithContentArray:(NSArray<NSString *> *)contentArr contentfont:(NSInteger)contentFont contentColor:(UIColor *)contentColor titleArray:(NSArray<NSString *> *)titleArr titleFont:(NSInteger)titleFont titleColor:(UIColor *)titleColor groupHeight:(NSInteger)groupHeight
{
    if (self = [super init]) {
        
        self.titleArray = titleArr;
        self.titleFont = titleFont;
        self.titleColor = titleColor;
        
        self.contentArray = contentArr;
        self.contentFont = contentFont;
        self.contentColor = contentColor;
        
        if (self.contentArray.count == 0) {
            self.dotSize = CGSizeMake(2, 2);
            self.dotColor = [UIColor lightGrayColor];
        }

        self.groupHeight = groupHeight;
        
        [self setupViewContent];
    }
    return self;
}

- (void)resetContentArray:(NSArray<NSString *> *)contentArr contentfont:(NSInteger)contentFont contentColor:(UIColor *)contentColor titleArray:(NSArray<NSString *> *)titleArr titleFont:(NSInteger)titleFont titleColor:(UIColor *)titleColor groupHeight:(NSInteger)groupHeight
{
    self.titleArray = titleArr;
    self.titleFont = titleFont;
    self.titleColor = titleColor;
    
    self.contentArray = contentArr;
    self.contentFont = contentFont;
    self.contentColor = contentColor;
    
    if (self.contentArray.count == 0) {
        self.dotSize = CGSizeMake(2, 2);
        self.dotColor = [UIColor lightGrayColor];
    }
    
    self.groupHeight = groupHeight;
    
    NSArray *subViewArr = self.subviews;
    for (UIView *tempView in subViewArr) {
        [tempView removeFromSuperview];
    }
    
    [self setupViewContent];
}

- (void)setupViewContent
{
    UIView *lastCellView = [[UIView alloc] init];

    for (int i = 0; i < self.contentArray.count; i++) {
        
        UIView *cellView = nil;
        if (self.contentArray.count == 0) {
            cellView = [self factaryCellViewWithContent:[self.contentArray objectAtIndex:i] title:nil];
            [self addSubview:cellView];
        }else {
            cellView = [self factaryCellViewWithContent:[self.contentArray objectAtIndex:i] title:[self.titleArray objectAtIndex:i]];
            [self addSubview:cellView];
        }
        
        if (i == 0) {
            [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mas_top).offset(0);
                make.left.mas_equalTo(self.mas_left).offset(0);
                make.right.mas_equalTo(self.mas_right).offset(0);
            }];
            lastCellView = cellView;
        }else if (i > 0 && i < self.contentArray.count - 1) {
            [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastCellView.mas_bottom).offset(self.groupHeight);
                make.left.mas_equalTo(self.mas_left).offset(0);
                make.right.mas_equalTo(self.mas_right).offset(0);
            }];
            lastCellView = cellView;
        }else {
            [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastCellView.mas_bottom).offset(self.groupHeight);
                make.left.mas_equalTo(self.mas_left).offset(0);
                make.right.mas_equalTo(self.mas_right).offset(0);
                make.bottom.mas_equalTo(self.mas_bottom).offset(0);
            }];
        }
        
        if (self.contentArray.count == 1) {
            [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.mas_bottom).offset(0);
            }];
        }
    }
    
    [self layoutIfNeeded];
}

- (UIView *)factaryCellViewWithContent:(NSString *)content title:(NSString *)title
{
    UIView *cellView = [[UIView alloc] init];
    
    UIView *dotView = nil;
    UILabel *titleLabel = nil;
    if (!title) {
        dotView = [[UIView alloc] init];
        dotView.backgroundColor = self.dotColor;
        [cellView addSubview:dotView];
        [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.dotSize);
            make.top.mas_equalTo(cellView.mas_top).offset(kDotY);
            make.left.mas_equalTo(cellView.mas_left).offset(0);
        }];
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.text = content;
        messageLabel.textColor = self.contentColor;
        messageLabel.font = [UIFont systemFontOfSize:self.contentFont];
        messageLabel.numberOfLines = 0;
        [cellView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cellView.mas_top).offset(0);
            make.left.mas_equalTo(dotView.mas_right).offset(3);
            make.right.mas_equalTo(cellView.mas_right).offset(0);
            make.bottom.mas_equalTo(cellView.mas_bottom).offset(0);
        }];
        
        return cellView;
        
    }else {

        titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textColor = self.titleColor;
        titleLabel.font = [UIFont systemFontOfSize:self.titleFont];
        titleLabel.numberOfLines = 1;
        [cellView addSubview:titleLabel];
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.text = content;
        messageLabel.textColor = self.contentColor;
        messageLabel.font = [UIFont systemFontOfSize:self.contentFont];
        messageLabel.numberOfLines = 0;
        [cellView addSubview:messageLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cellView.mas_top).offset(0);
            make.left.mas_equalTo(cellView.mas_left).offset(0);
        }];
        
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cellView.mas_top).offset(0);
            make.left.mas_equalTo(titleLabel.mas_right).offset(5);
            make.right.mas_equalTo(cellView.mas_right).offset(0);
            make.bottom.mas_equalTo(cellView.mas_bottom).offset(0);
        }];
        
        [titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

        [messageLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        [messageLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        
        return cellView;
    }
}

- (void)setTitleArray:(NSArray *)titleArray
{
    if (titleArray == nil) {
        _titleArray = @[];
    }else {
        _titleArray = titleArray;
    }
}

- (void)setTitleFont:(NSInteger)titleFont
{
    if (titleFont < 1) {
        _titleFont = 12;
    }else {
        _titleFont = titleFont;
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    if (titleColor == nil) {
        _titleColor = [UIColor lightGrayColor];
    }else {
        _titleColor = titleColor;
    }
}

- (void)setContentArray:(NSArray *)contentArray
{
    if (contentArray == nil) {
        _contentArray = @[];
    }else {
        _contentArray = contentArray;
    }
}

- (void)setContentFont:(NSInteger)contentFont
{
    if (contentFont < 1) {
        _contentFont = 12;
    }else {
        _contentFont = contentFont;
    }
}

- (void)setContentColor:(UIColor *)contentColor
{
    if (contentColor == nil) {
        _contentColor = [UIColor lightGrayColor];
    }else {
        _contentColor = contentColor;
    }
}

- (void)setDotSize:(CGSize)dotSize
{
    if (dotSize.width < 0 || dotSize.height < 0) {
        _dotSize = CGSizeMake(2, 2);
    }else {
        _dotSize = dotSize;
    }
}

- (void)setDotColor:(UIColor *)dotColor
{
    if (dotColor == nil) {
        _dotColor = [UIColor lightGrayColor];
    }else {
        _dotColor = dotColor;
    }
}

- (void)setGroupHeight:(NSInteger)groupHeight
{
    if (groupHeight < 0) {
        _groupHeight = 5;
    }else {
        _groupHeight = groupHeight;
    }
}

@end


