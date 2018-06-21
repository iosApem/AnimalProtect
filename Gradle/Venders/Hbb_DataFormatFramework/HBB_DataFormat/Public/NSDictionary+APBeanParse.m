//
//  NSDictionary+APBeanParse.m
//  HBB_DataFormatDemo
//
//  Created by chengenluo on 16/11/17.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import "NSDictionary+APBeanParse.h"
#import <objc/runtime.h>
#import "NSObject+APBeanParse.h"

@implementation NSDictionary (APBeanParse)

- (id)toBeanWithCls:(Class)cls
{
    id obj = [self.hbb_JSONParser dictionaryToBean:self cls:cls];
    return obj;
}

@end
