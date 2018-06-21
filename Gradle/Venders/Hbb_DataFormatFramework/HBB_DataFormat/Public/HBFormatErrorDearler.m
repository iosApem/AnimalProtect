//
//  HBFormatErrorDearler.m
//  Hbb_DataFormatFramework
//
//  Created by chengenluo on 2018/6/20.
//  Copyright © 2018年 CHENG DE LUO. All rights reserved.
//

#import "HBFormatErrorDearler.h"

@implementation HBFormatErrorDearler

- (void)dealWtihFormatError:(NSError *)error
{
    NSLog(@"\n**数据转化组件的愤怒**\n你错在哪:%ld %@ \n错误数据:%@", (long)error.code, error.domain, error.userInfo ?: @"");
}

@end
