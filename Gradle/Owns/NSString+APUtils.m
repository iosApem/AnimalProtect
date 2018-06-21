//
//  NSString+APUtils.m
//  AnimalProtect
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "NSString+APUtils.h"

@implementation NSString (APUtils)

+ (BOOL)notBlank:(NSString *)str
{
    BOOL flag = NO;
    if (str != nil && [str isEqualToString:@""] == NO) {
        flag = YES;
    } else {
        flag = NO;
    }
    return flag;
}

+ (NSString *)datetimeStrWithDate:(NSDate *)date
{
    NSString *format = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = format;
    NSString *datetimeStr = [fmt stringFromDate:date];
    
    return datetimeStr;
}

@end
