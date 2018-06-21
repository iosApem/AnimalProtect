//
//  BeanParser.h
//  KgOrderSys
//
//  Created by apem on 14-10-26.
//  Copyright (c) 2014年 CHENG DE LUO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "TypeAdapter.h"
#import "HBFormatErrorDearler.h"

/**
 转化为字符串时,遇到null的处理策略
 */
typedef enum {
    NullParseTypeDefautNull = 0,            //默认 转化为null
    NullParseTypeDoNotParseWhenNull = 1,    //不加入json转化
    NullParseTypeAlphabeticString = 2       //转化为空字符串
} NullParseType;

/**
 *  模型转化 工具类
 *
 *  @author apem
 */

@interface APBeanParser : NSObject

@property (nonatomic, strong) NSString *datetimeFormat;         //时间转化格式
@property (nonatomic, strong) NSString *dateFormat;             //日期转化格式
@property (nonatomic, assign) NullParseType nullParseType;     //空转化形式

@property (nonatomic, strong) NSMutableDictionary *adapterDict; //适配器字典
@property (nonatomic, strong) HBFormatErrorDearler *errDealer; //错误适配器

#pragma mark - Public Methods
/**
 *  初始化配置
 */
- (void)initConfig;

//NSDictionary为指定类
//dict 转 bean
- (id)parseToBean:(NSDictionary *)dict toClassArray:(NSArray * )clsArr;

//dict array 转 bean array
- (NSArray *)parseToBeanArr:(NSArray *)arr toClassArray:(NSArray * )clsArr;

//bean转NSDictionary
//参数: 1.实体类数组, 2.实体类的父类数组
- (NSDictionary *)beanToDictionary:(NSObject *)bean classArray:(NSArray *)clsArr;
//对象转字符串
//参数: 1.实体类数组, 2.实体类的父类数组
- (NSString *)beanToString:(NSObject *)bean classArray:(NSArray *)clsArr;

//字典转化为字符串
- (NSString *)dictionaryToString:(NSDictionary *)dict;

//实体类数组转字符串
//参数: 1.实体类数组, 2.实体类的父类数组
- (NSString *)beanArrToString:(NSArray *)array classArray:(NSArray *)clsArr;

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
 *  字典数组转化为JSON字符串
 *
 *  @param dictionaryArray  字典数组
 *
 *  @return JSON字符串
 */
- (NSString *)dictionaryArrayToJsonString:(NSArray *)dictionaryArray;;

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

#pragma mark - copy bean

//复制源BEAN中不为空的值给目标BEAN
//参数: 1.源对象 2.目标对象 3.类数组 (把这个类的所有父类的都放在 数组里)
+ (void)copyBeanToBean:(NSObject *)sourceObj targetObj:(NSObject *)targetObj classArray:(NSArray *)clsArr __deprecated_msg("方法被弃用. 请使用:copyBeanToBean:targetObj:");

//复制源BEAN中不为空的值给目标BEAN
//参数: 1.源对象 2.目标对象
+ (void)copyBeanToBean:(NSObject *)sourceObj targetObj:(NSObject *)targetObj;

/**
 *  检测并转化字符串中的特殊字符
 *
 *  @param str 字符串
 *
 *  @return 转化后的字符串
 */
- (NSString *)detectAndExchangeSpecialCharWithString:(NSString *)str;

#pragma mark - Public NSString && NSDate parse methods

// 转化时间戳 固定格式：/Date(1394259720000)/
+ (NSDate *)changePHPToNSDate:(NSString *)date withFormatter:(NSString *)format;

//时间格式化为字符串
+ (NSString *)dateToString:(NSDate *)date withFormatter:(NSString *)format;

//默认日期转换字符串
- (NSString *)dateToDefaultString:(NSDate *)date;

//默认日期时间转换字符串
- (NSString *)datetimeToDefaultString:(NSDate *)date;

//字符串转日期
+ (NSDate *)stringToDate:(NSString *)string withFormatter:(NSString *)format;

//默认字符串转日期
- (NSDate *)stringToDefaultDate:(NSString *)string;

//默认字符串转日期时间
- (NSDate *)stringToDefaultDatetime:(NSString *)string;

//获取NSDateComponents, 通过他可以获取年月日时分秒
+ (NSDateComponents *)getNSDateComponentsWithDate:(NSDate *)date;

//判断是否不为空
//支持 NSString, NSDate
+ (BOOL)isNotBlank:(NSObject *)obj;

#pragma mark - Abount Rejection

// 利用反射取得NSObject的属性，并存入到数组中
+ (NSArray *)getPropertyList:(NSArray *)clsArr;

@end
