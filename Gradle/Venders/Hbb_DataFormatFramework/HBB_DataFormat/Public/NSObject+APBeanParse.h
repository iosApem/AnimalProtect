//
//  NSObject+APBeanParse.h
//  HBB_DataFormatDemo
//
//  Created by chengenluo on 16/11/17.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hbb_JSONParser.h"

/**
 拓展JSON转化
 
 @author apem
 */
@interface NSObject (APBeanParse)

@property(nonatomic, strong) Hbb_JSONParser *hbb_JSONParser;

- (NSString *)toJSONString;

- (NSDictionary *)toDictionary;

@end
