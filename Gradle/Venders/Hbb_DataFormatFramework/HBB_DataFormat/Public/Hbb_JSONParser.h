//
//  Hbb_JSONParser.h
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/7/30.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TypeAdapter.h"
#import "HBFormatErrorDearler.h"

/**
 转化为字符串时,遇到null的处理策略
 */
typedef enum {
    Hbb_JSONParserNullParseTypeDefautNull = 0, //转化为空
    Hbb_JSONParserNullParseTypeNoNotParseWhenNull = 1, //不转化
    Hbb_JSONParserNullParseTypeAlphabeticString = 2, //转化为空字符串
} Hbb_JSONParserNullParseType; 

/**
 *  货宝宝JSON转化类
 *
 *  @author apem
 */
@interface Hbb_JSONParser : NSObject
///日期转化格式
@property (nonatomic, strong) NSString *dateFormat;
///日期/时间转化格式
@property (nonatomic, strong) NSString *datetimeFormat;
///空转化形式
@property (nonatomic, assign) Hbb_JSONParserNullParseType nullParseType;

- (void)registerTypeAdapter:(TypeAdapter *)adapter cls:(Class)cls;

- (void)registerErrDealer:(HBFormatErrorDearler *)errDealer;

/**
 *  JSON字符串转化为模型对象
 *
 *  @param jsonString JSON字符串
 *  @param cls        模型对象类型
 *
 *  @return 模型对象
 */
- (id)jsonStringToBean:(NSString *)jsonString cls:(Class)cls;

/**
 *  JSON字符串转化为模型对象数组
 *
 *  @param jsonString JSON字符串
 *  @param cls        模型对象类型
 *
 *  @return 模型对象数组
 */
- (NSArray *)jsonStringToBeanArray:(NSString *)jsonString cls:(Class)cls;

/**
 *  模型对象转化为JSON字符串
 *
 *  @param bean 模型对象
 *
 *  @return JSON字符串
 */
- (NSString *)beanToJsonString:(NSObject *)bean;

/**
 *  模型对象数组转化为JSON字符串
 *
 *  @param beanArray 模型对象数组
 *  @param cls       模型对象类型
 *
 *  @return JSON字符串
 */
- (NSString *)beanArrayToJsonString:(NSArray *)beanArray cls:(Class)cls;

/**
 *  JSON字符串转化为字典
 *
 *  @param jsonString  JSON字符串
 *
 *  @return 字典
 */
- (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString;

/**
 *  JSON字符串转化为字典数组
 *
 *  @param jsonString  JSON字符串
 *
 *  @return 字典数组
 */
- (NSArray *)jsonStringToDictionaryArray:(NSString *)jsonString;

/**
 *  字典转化为JSON字符串
 *
 *  @param dictionary 字典
 *
 *  @return JSON字符串
 */
- (NSString *)dictionaryToJsonString:(NSDictionary *)dictionary;

/**
 *  字典数组转化为JSON字符串
 *
 *  @param dictionaryArray  字典数组
 *
 *  @return JSON字符串
 */
- (NSString *)dictionaryArrayToJsonString:(NSArray *)dictionaryArray;

/**
 *  模型对象转化为字典
 *
 *  @param bean 模型对象
 *
 *  @return 字典
 */
- (NSDictionary *)beanToDictionary:(NSObject *)bean;

/**
 *  字典转化为模型对象
 *
 *  @param dictionary 字典
 *
 *  @return 模型对象
 */
- (id)dictionaryToBean:(NSDictionary *)dictionary cls:(Class)cls;

/**
 *  模型对象数组转化为字典数组
 *
 *  @param beanArray 模型对象数组
 *
 *  @return  字典数组
 */
- (NSArray *)beanArrayToDictionaryArray:(NSArray *)beanArray;

/**
 *  字典数组转化为对象数组
 *
 *  @param dictionaryArray 字典数组
 *  @param cls             模型对象类型
 *
 *  @return 对象数组
 */
- (NSArray *)dictionaryArrayToBeanArray:(NSArray *)dictionaryArray cls:(Class)cls;

/**
 普通数组转化为JSON数组
 
 @param array 普通数组
 */
- (NSArray *)arrayToJSONObjectArray:(NSArray *)array;

/**
 任何数组转JSON字符串
 
 @param array 任何数组
 */
- (NSString *)arrayToJSONString:(NSArray *)array;

/**
 任何对象转化为JSON字符串
 
 @param object 任何对象
 */
- (NSString *)objectToJsonString:(id)object;

@end
