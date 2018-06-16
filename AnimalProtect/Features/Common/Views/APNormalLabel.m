//
//  APNormalLabel.m
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import "APNormalLabel.h"
#import "HbbUIStyleCenter.h"

@implementation APNormalLabel

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
    UIFont *font = [[HbbUIStyleCenter defaultCenter] sysFontWithKey:kHbbUIStyleFontSizeStyleM];
    UIColor *color = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleTextColor];

    self.font = font;
    self.textColor = color;
}

@end
