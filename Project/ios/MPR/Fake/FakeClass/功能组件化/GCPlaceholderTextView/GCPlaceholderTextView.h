//
//  GCPlaceholderTextView.h
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  让 UITextView 在没有输入文字的时候支持填充placeholder（默认文字）。
 */
@interface GCPlaceholderTextView : UITextView 

@property(nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) UIColor *realTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) BOOL isAdjust;

@end
