//
//  NSString+APUtils.h
//  AnimalProtect
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (APUtils)

+ (BOOL)notBlank:(NSString *)str;


/**
 date对象转化为时间字符串

 @param date date对象
 */
+ (NSString *)datetimeStrWithDate:(NSDate *)date;

@end
