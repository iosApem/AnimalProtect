//
//  TypeAdapter.h
//  HBB_DataFormatDemo
//
//  Created by chengenluo on 17/2/18.
//  Copyright © 2017年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 类型适配器
 */
@interface TypeAdapter : NSObject

/**
 读

 @param origin 原数据
 @return 适配后的数据
 */
- (id)read:(id)origin;


/**
 读
 
 @param origin 原数据
 @return 适配后的数据
 */
- (id)write:(id)origin;

@end
