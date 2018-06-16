//
//  HbbUIStyleCenter.m
//  HbbUIStyle
//
//  Created by mige on 2017/2/9.
//  Copyright © 2017年 mige. All rights reserved.
//

#import "HbbUIStyleCenter.h"

@interface HbbUIStyleCenter ()

@property (nonatomic , strong) NSDictionary *styleDict; //样式

@end

@implementation HbbUIStyleCenter

#pragma mark - init
static HbbUIStyleCenter *defaultCenter;
+ (instancetype)defaultCenter{
    if (defaultCenter == nil) {
        defaultCenter = [[HbbUIStyleCenter alloc] init];
    }
    return defaultCenter;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *resourcePath = [NSBundle mainBundle].resourcePath;
        NSString *styleFilePath = [NSString stringWithFormat:@"%@/%@", resourcePath, kHbbUIStyleFileName];
        NSDictionary *styleDict = [NSDictionary dictionaryWithContentsOfFile:styleFilePath];
        self.styleDict = styleDict;

        
    }
    return self;
}

#pragma mark - public method

/**
 *  获取颜色
 */
- (UIColor *)colorWithKey:(NSString *)key{
    NSDictionary *uiDict = [self.styleDict objectForKey:kHbbUIStyleColorStyleName];
    UIColor *color = nil;
    if (key.length != 0) {
        NSString *value = [uiDict objectForKey:key];
        if (value != nil && value.length != 0) {
            color = [self colorFromHexString:value];
        }
    }
    return color;
}

/**
 *  获取字体大小
 */
- (CGFloat)fontSizeWithKey:(NSString *)key{
    NSDictionary *uiDict = [self.styleDict objectForKey:kHbbUIStyleFontSizeStyleName];
    CGFloat fontSize = 0;
    if (key.length != 0) {
        NSNumber *value = [uiDict objectForKey:key];
        if (value != nil) {
            fontSize = [value floatValue];
        }
    }
    return fontSize;
}

- (UIFont *)sysFontWithKey:(NSString *)key{
    CGFloat fontSize = [self fontSizeWithKey:key];
    UIFont *sysFont = [UIFont systemFontOfSize:fontSize];
    return sysFont;
}

#pragma mark - private method
//十六进制转颜色
- (UIColor *)colorFromHexString:(NSString *)hexString{
    UIColor *color = [UIColor clearColor];
    //删除字符串中的空格
    NSString *cString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cString = [cString uppercaseString];
    //0x开头，从索引2开始截取字符串
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    //#开头，从索引1开始截取字符串
    if ([cString hasPrefix:@"#"]){
        cString = [cString substringFromIndex:1];
    }
    
    //截取字符串后，字符串长度等于6或者等于8，等于8时代表包含透明度值
    if (cString.length == 6 || cString.length == 8) {
        // Separate into r, g, b substrings
        int offset = 0;
        NSRange range;
        range.length = 2;
        
        //alpha
        NSString *aString = @"FF"; //不透明
        if (cString.length == 8) {
            offset = 2;
            range.location = 0;
            aString = [cString substringWithRange:range];
        }
        
        //red
        range.location = 0 + offset;
        NSString *rString = [cString substringWithRange:range];
        //green
        range.location = 2 + offset;
        NSString *gString = [cString substringWithRange:range];
        //blue
        range.location = 4 + offset;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b, a;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        
        color = [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
    }
    return color;
}



@end
