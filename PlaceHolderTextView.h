//
//  PlaceHolderTextView.h
//  DemoPlaceholderTextView
//
//  Created by zhangshaoyu on 15/7/8.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView

/// 占位符提示语
@property (nonatomic, strong) NSString *placeHolderText;

/// 占位符提示语字体大小
@property (nonatomic, strong) UIFont *placeHolderFont;

/// 占位符提示语字体颜色
@property (nonatomic, strong) UIColor *placeHolderColor;

/// 限制字数
@property (nonatomic, assign) NSInteger limitNumber;

/// 回调
- (void)textViewStart:(void (^)(UITextView *textview))start
    changeTextInRange:(void (^)(UITextView *textview, NSRange range, NSString *text))changeTextInRange
   changeNotification:(void (^)(UITextView *textview))changeNotification
                  end:(void (^)(UITextView *textview))end;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view;

@end
