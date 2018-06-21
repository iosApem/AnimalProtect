//
//  NSObject+APBeanParse.m
//  HBB_DataFormatDemo
//
//  Created by chengenluo on 16/11/17.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import "NSObject+APBeanParse.h"
#import <objc/runtime.h>

static char *static_NSObjectAPBeanParseHbb_JSONParserKey = "hbb_JSONParser";

@implementation NSObject (APBeanParse)

- (void)setHbb_JSONParser:(Hbb_JSONParser *)hbb_JSONParser
{
    objc_setAssociatedObject(self, static_NSObjectAPBeanParseHbb_JSONParserKey, hbb_JSONParser, OBJC_ASSOCIATION_RETAIN);
}

- (Hbb_JSONParser *)hbb_JSONParser
{
    Hbb_JSONParser *hbb_JSONParser = objc_getAssociatedObject(self, static_NSObjectAPBeanParseHbb_JSONParserKey);
    if (hbb_JSONParser == nil) {
        hbb_JSONParser = [[Hbb_JSONParser alloc] init];
        [self setHbb_JSONParser:hbb_JSONParser];
    }
    
    return hbb_JSONParser;
}

- (NSString *)toJSONString
{
    NSString *jsonString = [self.hbb_JSONParser objectToJsonString:self];
    return jsonString;
}

- (NSDictionary *)toDictionary
{
    NSDictionary *dict;
    if ([self isKindOfClass:[NSArray class]] == NO) {
        
        dict = [self.hbb_JSONParser beanToDictionary:self];
        
    } else {
        NSLog(@"dateformate:%s:不支持改转化", __func__);
    }
    
    return dict;
}

- (NSArray *)toJSONArray
{
    NSArray *arr;
    if ([self isKindOfClass:[NSArray class]] == YES) {
        
        NSArray *beanArr = (NSArray *)self;
        arr = [self.hbb_JSONParser arrayToJSONObjectArray:beanArr];
        
    } else {
        NSLog(@"dateformate:%s:不支持改转化", __func__);
    }
    
    return arr;
}

- (NSArray *)toBeanArray
{
    NSArray *arr;
    if ([self isKindOfClass:[NSArray class]] == YES) {
        
        NSArray *dictArr = (NSArray *)self;
        arr = [self.hbb_JSONParser beanArrayToDictionaryArray:dictArr];
        
    } else {
        NSLog(@"dateformate:%s:不支持改转化", __func__);
    }
    
    return arr;
}

@end
