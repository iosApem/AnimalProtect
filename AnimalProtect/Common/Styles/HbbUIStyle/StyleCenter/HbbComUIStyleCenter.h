//
//  HbbComUIStyleCenter.h
//  HbbUIStyle
//
//  Created by mige on 2017/4/5.
//  Copyright © 2017年 mige. All rights reserved.
//
/**
 *  常用样式中心
 *
 *  @author mige
 */
#import <Foundation/Foundation.h>
#import "HbbLabelStyle.h"
#import "HbbButtonStyle.h"
#import "HbbImageViewStyle.h"
#import "HbbTextFieldStyle.h"
#import "HbbTextViewStyle.h"
#import "HbbSwitchStyle.h"
#import "HbbSegmentedControlStyle.h"


@interface HbbComUIStyleCenter : NSObject

/**
 单例
 */
+ (instancetype)defaultCenter;

/**
 获取常用Label样式
 */
- (HbbLabelStyle *)getLabelStyleWithHbbStyle:(NSString *)hbbStyle;

/**
 获取常用View样式
 */
- (HbbUIStyle *)getViewStyleWithHbbStyle:(NSString *)hbbStyle;

/**
 获取常用Button样式
 */
- (HbbButtonStyle *)getButtonStyleWithHbbStyle:(NSString *)hbbStyle;

/**
 获取常用TextField样式
 */
- (HbbTextFieldStyle *)getTextFieldStyleWithHbbStyle:(NSString *)hbbStyle;

/**
 获取常用ImageView样式
 */
- (HbbImageViewStyle *)getImageViewStyleWithHbbStyle:(NSString *)hbbStyle;

/**
 获取常用Switch样式
 */
- (HbbSwitchStyle *)getSwitchStyleWithHbbStyle:(NSString *)hbbStyle;

/**
 获取常用TextView样式
 */
- (HbbTextViewStyle *)getTextViewStyleWithHbbStyle:(NSString *)hbbStyle;

/**
 获取常用SegmentedControl样式
 */
- (HbbSegmentedControlStyle *)getSegmentedControlStyleWithHbbStyle:(NSString *)hbbStyle;

@end
