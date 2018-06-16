//
//  UIImage+HpUtil.m
//  HPExcelView
//
//  Created by LUOCHENG DE on 16/1/20.
//  Copyright © 2016年 LUOCHENG DE. All rights reserved.
//

#import "UIImage+HpUtil.h"

@implementation UIImage (HpUtil)

+ (UIImage *)HpUtil_imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
