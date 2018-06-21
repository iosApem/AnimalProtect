//
//  HBFormatErrorDearler.h
//  Hbb_DataFormatFramework
//
//  Created by chengenluo on 2018/6/20.
//  Copyright © 2018年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 数据转化失败错误代码
 */
typedef enum {
    HBFormatErrorCodeParamNil = -100007  //参数不能为空
}HBFormatErrorCode;

/**
 数据转化失败错误描述
 */
typedef NSString *HBFormatErrorDesc;
static HBFormatErrorDesc HBFormatErrorDescParamNil = @"参数不能为空";

/**
 格式化出错处理
 
 @author apem
 */
@interface HBFormatErrorDearler : NSObject

/**
 处理出错 (默认输出系统日志)

 @param error 错误对象
 */
- (void)dealWtihFormatError:(NSError *)error;

@end
