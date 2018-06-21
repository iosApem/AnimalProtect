//
//  NSString+APBeanParse.m
//  HBB_DataFormatDemo
//
//  Created by chengenluo on 16/11/17.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import "NSString+APBeanParse.h"
#import "NSObject+APBeanParse.h"

@implementation NSString (APBeanParse)

- (NSString *)toJSONString
{
    return self;
}

- (NSDictionary *)toDictionary
{
    NSDictionary *dict = [self.hbb_JSONParser jsonStringToDictionary:self];
    return dict;
}

- (NSArray *)toJSONArray
{
    NSArray *arr = [self.hbb_JSONParser jsonStringToDictionaryArray:self];
    return arr;
}

- (NSArray *)toBeanArrayWithCls:(Class)cls
{
    NSArray *clsArr = [self.hbb_JSONParser jsonStringToBeanArray:self cls:cls];
    return clsArr;
}

@end
