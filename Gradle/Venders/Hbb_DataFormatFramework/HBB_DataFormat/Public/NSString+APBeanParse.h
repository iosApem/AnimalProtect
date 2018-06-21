//
//  NSString+APBeanParse.h
//  HBB_DataFormatDemo
//
//  Created by chengenluo on 16/11/17.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (APBeanParse)

- (NSDictionary *)toDictionary;

- (NSArray *)toJSONArray;

- (NSArray *)toBeanArrayWithCls:(Class)cls;

@end
