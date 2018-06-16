//
//  APRedBtn.m
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import "APRedBtn.h"
#import "HbbUIStyleCenter.h"
#import "UIImage+HpUtil.h"

@implementation APRedBtn

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self initFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initFromNib];
    }
    return self;
}

- (void)initFromNib
{
    [self setColorStyle:APRedBtnColorStyleRed];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    CGFloat fontSize = [[HbbUIStyleCenter defaultCenter] fontSizeWithKey:kHbbUIStyleFontSizeStyleM];
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setColorStyle:(NSInteger)colorStyle
{
    _colorStyle = colorStyle;
    if(self.colorStyle == APRedBtnColorStyleRed) {
        UIColor *color = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleButtonRedColor];
        self.backgroundColor = color;
    } else {
        UIColor *color = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleButtonBlueColor];
        self.backgroundColor = color;
    }
    
    UIColor *disableColor = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleButtonDiableColor];
    UIImage *image = [UIImage HpUtil_imageWithColor:disableColor size:self.bounds.size];
    
    [self setBackgroundImage:image forState:UIControlStateDisabled];
}

@end
