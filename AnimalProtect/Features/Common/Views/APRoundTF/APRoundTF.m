//
//  APRoundTF.m
//  AnimalProtect
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APRoundTF.h"
#import "HbbUIStyleCenter.h"

@implementation APRoundTF

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
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    [self setRoundColor:APRoundTFRoundColorGray];
    
    CGFloat fontSize = [[HbbUIStyleCenter defaultCenter] fontSizeWithKey:kHbbUIStyleFontSizeStyleM];
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setRoundColor:(APRoundTFRoundColor)roundColor
{
    if (roundColor == APRoundTFRoundColorYellow) {
        UIColor *color = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleTextFieldRoundYellow];
        self.layer.borderColor = color.CGColor;
    } else {
        UIColor *color = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleTextFieldRoundNormal];
        self.layer.borderColor = color.CGColor;
    }
}

@end
