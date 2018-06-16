//
//  HbbUIStyleCenter.h
//  HbbUIStyle
//
//  Created by mige on 2017/2/9.
//  Copyright © 2017年 mige. All rights reserved.
//

/**
 *  UI样式中心
 *
 *  @author mige
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HbbUIStyleMacro.h"

@interface HbbUIStyleCenter : NSObject

/**
 单例
 */
+ (instancetype)defaultCenter;

/**
 *  获取颜色
 *
 *  @param key 颜色样式key
 */
- (UIColor *)colorWithKey:(NSString *)key;

/**
 *  获取字体大小
 *
 *  @param key 字体样式key
 */
- (CGFloat)fontSizeWithKey:(NSString *)key;


/**
 获取字体

 @param key 字体样式key
 */
- (UIFont *)sysFontWithKey:(NSString *)key;

@end
