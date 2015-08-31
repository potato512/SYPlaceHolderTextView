//
//  PlaceHolderTextView.m
//  DemoPlaceholderTextView
//
//  Created by zhangshaoyu on 15/7/8.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "PlaceHolderTextView.h"

#define originX 8.0
#define originY 6.0

@interface PlaceHolderTextView () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeHolderlabel;

@property (nonatomic, copy) void (^startBlock)(UITextView *textview);
@property (nonatomic, copy) void (^changeRankBlock)(UITextView *textview, NSRange range, NSString *text);
@property (nonatomic, copy) void (^changeBlock)(UITextView *textview);
@property (nonatomic, copy) void (^endBlock)(UITextView *textview);

@end

@implementation PlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame view:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (view)
        {
            [view addSubview:self];
        }
        
        [self setUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewEditChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 创建视图

- (void)setUI
{
    self.delegate = self;
    
    self.placeHolderlabel = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, (self.frame.size.width - originX * 2), 0.0)];
    [self addSubview:self.placeHolderlabel];
    self.placeHolderlabel.textAlignment = NSTextAlignmentLeft;
    self.placeHolderlabel.numberOfLines = 0;
    self.placeHolderlabel.hidden = YES;
}

- (void)resetPlaceholderlabel
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:self.placeHolderlabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize rtSize = [self.placeHolderlabel.text boundingRectWithSize:CGSizeMake(self.placeHolderlabel.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    CGFloat height = ceil(rtSize.height) + 0.5;
    
    CGRect rect = self.placeHolderlabel.frame;
    rect.size.height = height;
    self.placeHolderlabel.frame = rect;
}

#pragma mark - methord

- (void)textViewStart:(void (^)(UITextView *textview))start
    changeTextInRange:(void (^)(UITextView *textview, NSRange range, NSString *text))changeTextInRange
   changeNotification:(void (^)(UITextView *textview))changeNotification
                  end:(void (^)(UITextView *textview))end
{
    self.startBlock = start;
    self.changeRankBlock = changeTextInRange;
    self.changeBlock = changeNotification;
    self.endBlock = end;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSString *string = textView.text;
    self.placeHolderlabel.hidden = ((!string || 0 >= string.length) ? NO : YES);

    if (self.startBlock)
    {
        self.startBlock(textView);
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSString *string = textView.text;
    self.placeHolderlabel.hidden = ((!string || 0 >= string.length) ? NO : YES);
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.changeRankBlock)
    {
        self.changeRankBlock(textView, range, text);
    }
    
    return YES;
}

- (void)textViewEditChanged:(NSNotification *)notification
{
    NSString *string = self.text;
    self.placeHolderlabel.hidden = ((!string || 0 >= string.length) ? NO : YES);
    
    if ([self isFirstResponder])
    {
        if (_limitNumber != 0)
        {
            // 默认不限制字数
            NSString *toBeString = self.text;
            if (toBeString.length > _limitNumber)
            {
                self.text = [toBeString substringToIndex:_limitNumber];
            }
        }
    }
    
    if (self.changeBlock)
    {
        self.changeBlock(self);
    }
}

#pragma mark - setter

- (void)setPlaceHolderText:(NSString *)placeHolderText
{
    _placeHolderText = placeHolderText;
    if (_placeHolderText && 0 < _placeHolderText.length)
    {
        self.placeHolderlabel.text = _placeHolderText;
        self.placeHolderlabel.hidden = NO;
        
        [self resetPlaceholderlabel];
    }
}

- (void)setPlaceHolderFont:(UIFont *)placeHolderFont
{
    _placeHolderFont = placeHolderFont;
    if (_placeHolderFont)
    {
        self.placeHolderlabel.font = _placeHolderFont;
        
        [self resetPlaceholderlabel];
    }
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor = placeHolderColor;
    self.placeHolderlabel.textColor = _placeHolderColor;
}

- (void)setLimitNumber:(NSInteger)limitNumber
{
    _limitNumber = limitNumber;
}

@end
