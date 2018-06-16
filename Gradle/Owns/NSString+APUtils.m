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

@end
