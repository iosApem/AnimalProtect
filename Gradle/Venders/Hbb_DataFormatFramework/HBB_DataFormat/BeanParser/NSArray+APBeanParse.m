//
//  NSArray+APBeanParse.m
//  HBB_DataFormatDemo
//
//  Created by chengenluo on 16/11/17.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import "NSArray+APBeanParse.h"
#import <objc/runtime.h>
#import "NSObject+APBeanParse.h"

@implementation NSArray (APBeanParse)

- (NSArray *)toJSONObjectArray
{
    NSArray *array = [self.hbb_JSONParser arrayToJSONObjectArray:self];
    return array;
}

@end
