//
//  NSDictionary+APBeanParse.h
//  HBB_DataFormatDemo
//
//  Created by chengenluo on 16/11/17.
//  Copyright © 2016年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hbb_JSONParser.h"

@interface NSDictionary (APBeanParse)

- (id)toBeanWithCls:(Class)cls;

@end
