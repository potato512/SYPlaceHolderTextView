//
//  SYPlaceHolderTextView.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/7/8.
//  Copyright (c) 2015年 365sji. All rights reserved.
//  继承自UITextView，且带有占位符和block回调的自定义textview

#import <UIKit/UIKit.h>

@interface SYPlaceHolderTextView : UITextView

/// 占位符提示语（默认无）
@property (nonatomic, strong) NSString *placeHolderText;

/// 占位符提示语字体大小（默认与textview的系统字体大小一致）
@property (nonatomic, strong) UIFont *placeHolderFont;

/// 占位符提示语字体颜色（默认灰色）
@property (nonatomic, strong) UIColor *placeHolderColor;

/// 限制字数（默认无限制）
@property (nonatomic, assign) NSInteger limitNumber;

/// 回车时结束编辑
@property (nonatomic, assign) BOOL isEndReturn;

/// 回调
- (void)textViewStart:(void (^)(UITextView *textview))start
    changeTextInRange:(void (^)(UITextView *textview, NSRange range, NSString *text))changeTextInRange
   changeNotification:(void (^)(UITextView *textview))changeNotification
                  end:(void (^)(UITextView *textview))end;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view;

@end
