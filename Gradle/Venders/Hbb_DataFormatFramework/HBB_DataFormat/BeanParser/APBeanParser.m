//
//  BeanParser.m
//  KgOrderSys
//
//  Created by apem on 14-10-26.
//  Copyright (c) 2014年 CHENG DE LUO. All rights reserved.
//

#import "APBeanParser.h"
#import <objc/runtime.h>
#import "NSDictionary+DateString.h"
#import "NSArray+DateString.h"
#import "HBFormatErrorDearler.h"

/**
 * JSON 转化注意问题
 * 1. 转化时只识别 NSDictionary 和 普通对象数组
 * 2. NSDictionary值不能为nil(空引用)
 
 
 NSString类型: T@"NSString",&,N,V_UserID
 Block类型: T@?,&,N,V_myBlock
 id类型: T@,&,N,V_myBean

 *
 */

//KVC

#define APBeanParser_DefaultDateTimeFormat @"yyyy-MM-dd HH:mm:ss"
#define APBeanParser_DefaultDateFormat @"yyyy-MM-dd"

static NSString *APBeanParserPHPDatePrefix = @"/Date(";
static NSString *APBeanParserPHPDateSuffix = @")/";

@interface APBeanParser ()

@property (nonatomic, strong) NSArray *allowedJSONTypes;
//@property (nonatomic, strong) NSArray *allowedPrimitiveTypes;

@end

@implementation APBeanParser

#pragma mark - Public Methods

- (instancetype)init
{
    if (self = [super init]) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig
{
    self.dateFormat = APBeanParser_DefaultDateFormat;
    self.datetimeFormat = APBeanParser_DefaultDateTimeFormat;
    
    self.allowedJSONTypes = @[
                         [NSString class], [NSNumber class], [NSDate class], [NSDecimalNumber class], [NSArray class], [NSDictionary class], [NSNull class], //immutable JSON classes
                         [NSMutableString class], [NSMutableArray class], [NSMutableDictionary class] //mutable JSON classes
                         ];
    
//    self.allowedPrimitiveTypes = @[
//                              @"BOOL", @"float", @"int", @"long", @"double", @"short",
//                              //and some famous aliases
//                              @"NSInteger", @"NSUInteger",
//                              @"Block"
//                              ];

}

//dict 转 bean
- (id)parseToBean:(NSDictionary *)dict toClassArray:(NSArray * )clsArr
{
    id obj;
    if (dict != nil) {
        
        Class cls = [clsArr firstObject];
        obj = [[cls alloc] init];
        unsigned int outCount;
        for (NSInteger k = 0; k < clsArr.count; k ++) {
            Class curCls = [clsArr objectAtIndex:k];
            objc_property_t *properties = class_copyPropertyList(curCls, &outCount);
            for (unsigned int i = 0; i < outCount; i ++) {
                objc_property_t myProperty = properties[i];
                NSString *propertyName = [NSString stringWithUTF8String:property_getName(myProperty)];
                
                const char *attr = property_getAttributes(myProperty);
                NSString *nsAttr = [[NSString alloc] initWithUTF8String:attr];
                
                //如果是JSON支持的常规类型
                if ([self property_attrJSONArrowType:nsAttr] == YES) {
                    
                    id value = [dict objectForKey:propertyName];
                    
                    //字符串
                    if([value isKindOfClass:[NSString class]]) {
                        
                        //如果需要被转化的类型是NSDate
                        if ([nsAttr containsString:@"@\"NSDate\""]) {
                            //PHP时间
                            if ([APBeanParser isPHPNSDate:[dict objectForKey:propertyName]]) {
                                NSDate *date = [APBeanParser changePHPToNSDate:value withFormatter:self.datetimeFormat];
                                [obj setValue:date forKey:propertyName];
                                
                                //日期格式
                            }else if([self isDateFormat:value] == YES) {
                                NSDate *date = [self stringToDefaultDate:value];
                                [obj setValue:date forKey:propertyName];
                                
                                //日期时间格式
                            }else if([self isDatetimeFormat:value] == YES) {
                                NSDate *date = [self stringToDefaultDatetime:value];
                                [obj setValue:date forKey:propertyName];
                                
                            } else {
                                //do something
                            }
                        } else {
                            
                            //不为空字符串
                            if(value != nil){
                                [obj setValue:value forKey:propertyName];
                            }
                        }
                        
                        //NSNull类型
                    } else if([value isKindOfClass:[NSNull class]] == YES) {
                        //不做赋值操作
                        
                        //不为空其他类型
                    } else {
                        if (value != nil) {
                            [obj setValue:value forKey:propertyName];
                        }
                    }
                    //自定义对象类型,并且不是基本类型
                } else if([nsAttr containsString:@"@"]) {
                    //如果是自定义对象类型
                    if ([nsAttr containsString:@"\""]) {
                        NSDictionary *attrDict = [dict objectForKey:propertyName];
                        Class attrObjCls = [self getClassWithPropertyAttribute:nsAttr];
                        NSArray *clsArray = [APBeanParser getClassArrayWithClass:attrObjCls exceptClass:[NSObject class]];
                        //如果字典不为空
                        if(attrDict) {
                            id attrBean = [self parseToBean:attrDict toClassArray:clsArray];
                            //如果转化后的对象不为空
                            if (attrBean) {
                                [obj setValue:attrBean forKey:propertyName];
                            } else {
                                [obj setValue:[NSNull null] forKey:propertyName];
                            }
                        }
                        
                        //block类型
                    } else if([nsAttr containsString:@"@?"] == YES) {
                        id idObj =  [dict objectForKey:propertyName];
                        //不为空则设置
                        if(idObj != nil && [idObj isKindOfClass:[NSNull class]] == NO) {
                            [obj setValue:idObj forKey:propertyName];
                        }
                        //id类型
                    } else {
                        id idObj =  [dict objectForKey:propertyName];
                        [obj setValue:idObj forKey:propertyName];
                    }
                }
                
            }
            free(properties);
        }
        
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:dict:%@", HBFormatErrorDescParamNil, __func__, dict];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    return obj;
}

//dict array 转 bean array
- (NSArray *)parseToBeanArr:(NSArray *)arr toClassArray:(NSArray * )clsArr
{
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i ++) {
        [mutableArr addObject:[self parseToBean:[arr objectAtIndex:i] toClassArray:clsArr]];
    }
    return  [mutableArr copy];
}

//bean转NSDictionary
//参数:BEAN cls:以什么类被转化
- (NSDictionary *)beanToDictionary:(NSObject *)bean classArray:(NSArray *)clsArr
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    
    //如果还有父类的属性
    if (clsArr && clsArr.count > 0) {
        unsigned int j;
        for( j = 0;j < clsArr.count;j ++) {
            unsigned int outCount;
            unsigned int i;
            Class curCls = [clsArr objectAtIndex:j];
            objc_property_t *properties = class_copyPropertyList(curCls, &outCount);
            for (i = 0; i < outCount; i ++) {
                objc_property_t property = properties[i];
                NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                SEL selGet = NSSelectorFromString(key);
                
                const char *attr = property_getAttributes(property);
                NSString *nsAttr = [[NSString alloc] initWithUTF8String:attr];
                
                NSObject *valObj = [bean valueForKey:key];
                
                //如果是常规类型
                if ([self property_attrJSONArrowType:nsAttr] == YES) {
                    
                    //是否数组类型
                    if ([self isArrayType:nsAttr] == YES) {
                        NSArray *oldArr = [bean valueForKey:key];
                        NSArray *arr = [self arrayToJSONObjectArray:oldArr];
                        
                        if (arr) {
                            
                            [mutableDict setObject:arr forKey:key];
                        }else {
                            
                            //实体类转化为字典时,如果设置值为nil, 根据传入的null转化类型来设置字典的value值
                            [self setNilWhenBeanParseToDictionary:mutableDict key:key nullParseType:self.nullParseType];
                            
                        }
                        
                    //非数组的常规类型
                    } else {
                        if (bean && [bean respondsToSelector:selGet]) {
                            
                            //NSDctionary的值不能为nil
                            if (valObj) {
                                
                                [mutableDict setObject:valObj forKey:key];
                            }else {
                                
                                //实体类转化为字典时,如果设置值为nil, 根据传入的null转化类型来设置字典的value值
                                [self setNilWhenBeanParseToDictionary:mutableDict key:key nullParseType:self.nullParseType];
                                
                            }
                        }
                    }
                
                //NSData类型
                } else if([nsAttr containsString:@"@"] == YES
                          && [nsAttr containsString:@"NSData"] == YES) {
                    
                    //不加入字典
                    
                //自定义对象类型
                } else if([nsAttr containsString:@"@"]) {
                    
                    //如果是自定义对象类型
                    if ([nsAttr containsString:@"\""]) {
                        id obj = [bean valueForKey:key];
                        //对象不为空
                        if (obj) {
                            NSArray *clsArray = [APBeanParser getClassArrayWithClass:[obj class] exceptClass:[NSObject class]];
                            NSDictionary *dict = [self beanToDictionary:obj classArray:clsArray];
                            //字典不为空
                            if(dict) {
                                [mutableDict setObject:dict forKey:key];
                                //字典为空
                            } else {
                                
                                //实体类转化为字典时,如果设置值为nil, 根据传入的null转化类型来设置字典的value值
                                [self setNilWhenBeanParseToDictionary:mutableDict key:key nullParseType:self.nullParseType];
                            }
                            
                        //对象为空
                        } else {
                            
                            //实体类转化为字典时,如果设置值为nil, 根据传入的null转化类型来设置字典的value值
                            [self setNilWhenBeanParseToDictionary:mutableDict key:key nullParseType:self.nullParseType];
                        }
                        
                    //id类型
                    } else {
                        id obj = [bean valueForKey:key];
                        //不为空
                        if (obj) {
                            [mutableDict setObject:obj forKey:key];
                            //为空
                        } else {
                            
                            //实体类转化为字典时,如果设置值为nil, 根据传入的null转化类型来设置字典的value值
                            [self setNilWhenBeanParseToDictionary:mutableDict key:key nullParseType:self.nullParseType];
                        }
                    }

                }
                
            }
            free(properties);
        }
    }
    
    return [mutableDict copy];
}

//字典转化为字符串
- (NSString *)dictionaryToString:(NSDictionary *)dict
{
    dict = [dict getDictionaryChangeDateToString:self.datetimeFormat];
    NSString *string = [self nativeJSONObjectToJSONString:dict error:nil];
    //检测并转化字符串中的特殊字符
    string = [self detectAndExchangeSpecialCharWithString:string];
    
    return string;
}

//对象转字符串
- (NSString *)beanToString:(NSObject *)bean classArray:(NSArray *)clsArr
{
    NSDictionary *dict = [self beanToDictionary:bean classArray:clsArr];
    dict = [dict getDictionaryChangeDateToString:self.datetimeFormat];
    NSString *str = [self nativeJSONObjectToJSONString:dict error:nil];
    
    //检测并转化字符串中的特殊字符
    str = [self detectAndExchangeSpecialCharWithString:str];
    
    return str;
}

//实体类数组转字符串
- (NSString *)beanArrToString:(NSArray *)array classArray:(NSArray *)clsArr
{
    NSMutableArray *mulArr = [NSMutableArray array];
    for(NSObject *bean in array) {
        [mulArr addObject:[self beanToDictionary:bean classArray:clsArr]];
    }
        
    mulArr = [[mulArr getArrayChangeDateToString:self.datetimeFormat] mutableCopy];

    NSString *str = [self nativeJSONObjectToJSONString:mulArr error:nil];
    
    //检测并转化字符串中的特殊字符
    str = [self detectAndExchangeSpecialCharWithString:str];
    
    return str;
}

- (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString
{
    NSDictionary *dict;
    if (jsonString != nil && [jsonString isEqualToString:@""] == NO) {
        //解决换行符带来的冲突
        NSString *str = [self detectAndExchangeSpecialCharWithStringBeforeExchangeToJSONObjectWithStr:jsonString];
        dict = [self nativeJSONStringToJSONObject:str error:nil];
        
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:jsonString:%@", HBFormatErrorDescParamNil, __func__, jsonString];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    return dict;
}

- (NSArray *)jsonStringToDictionaryArray:(NSString *)jsonString
{
    NSArray *arr;
    if (jsonString != nil && [jsonString isEqualToString:@""] == NO) {
        //解决换行符带来的冲突
        NSString *str = [self detectAndExchangeSpecialCharWithStringBeforeExchangeToJSONObjectWithStr:jsonString];
        arr = [self nativeJSONStringToJSONObject:str error:nil];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:jsonString:%@", HBFormatErrorDescParamNil, __func__, jsonString];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return arr;
}

- (NSString *)dictionaryArrayToJsonString:(NSArray *)dictionaryArray
{
    NSString *string;
    if(dictionaryArray != nil) {
        dictionaryArray = [dictionaryArray getArrayChangeDateToString:self.datetimeFormat];
        string = [self nativeJSONObjectToJSONString:dictionaryArray error:nil];
        
        //检测并转化字符串中的特殊字符
        string = [self detectAndExchangeSpecialCharWithString:string];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:dictionaryArray:%@", HBFormatErrorDescParamNil, __func__, dictionaryArray];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return string;
}


/**
 普通数组转化为JSON数组

 @param array 普通数组
 */
- (NSArray *)arrayToJSONObjectArray:(NSArray *)array
{
    NSMutableArray *arr = [NSMutableArray array];
    
    //如果真是数组类型才继续
    if([array isKindOfClass:[NSArray class]] == YES) {
        id obj;
        id newObj;
        for (NSInteger i = 0; i < array.count; i ++) {
            obj = [array objectAtIndex:i];
            NSString *clsStr = NSStringFromClass([obj class]);
            
            //是否JSON允许对象类型
            if ([self isAllowedJSONObjectTypes:clsStr] == YES) {
                
                //数组类型
                if ([obj isKindOfClass:[NSArray class]] == YES) {
                    
                    newObj = [self arrayToJSONObjectArray:obj];
                    
                    //其他类型
                } else {
                    newObj = obj;
                }
                
                //自定义对象
            } else {
                
                NSArray *clsArr = [APBeanParser getClassArrayWithClass:[obj class] exceptClass:[NSObject class]];
                newObj = [self beanToDictionary:obj classArray:clsArr];
                
            }
            
            if (newObj != nil) {
                [arr addObject:newObj];
            } else {
                NSLog(@"dataformat:数据转化失败,传入对象不合法!");
            }
            
        }
    }
    return arr;
}

/**
 任何数组转JSON字符串

 @param array 任何数组
 */
- (NSString *)arrayToJSONString:(NSArray *)array
{
    NSArray *arr = [self arrayToJSONObjectArray:array];
    //对日期进行格式转化
    NSArray * newArr = [arr getArrayChangeDateToString:self.datetimeFormat];
    
    NSString *jsonString = [self nativeJSONObjectToJSONString:newArr error:nil];
    
    //检测并转化字符串中的特殊字符
    jsonString = [self detectAndExchangeSpecialCharWithString:jsonString];
    
    return jsonString;
}

- (NSString *)objectToJsonString:(id)object
{
    NSString *jsonString;
    //数组
    if ([object isKindOfClass:[NSArray class]] == YES) {
        jsonString = [self arrayToJSONString:object];
        
    //字典
    } else if([object isKindOfClass:[NSDictionary class]] == YES) {
        jsonString = [self dictionaryToString:object];
        
    //自定义对象
    } else {
        NSArray *clsArr = [APBeanParser getClassArrayWithClass:[object class] exceptClass:[NSObject class]];
        jsonString = [self beanToString:object classArray:clsArr];
    }
    return jsonString;
}

/**
 原生JSON字符串转JSON集合对象

 @param string JSON字符串
 @param err 错误对象
 */
- (id)nativeJSONStringToJSONObject:(NSString *)string error:(NSError **)err
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:err];
    
    obj = [self dealAdapterWithJSONObject:obj];
    
    return obj;
}

/**
 原生JSON集合对象转JSON字符串
 
 @param string JSON集合对象
 @param err 错误对象
 */
- (NSString *)nativeJSONObjectToJSONString:(id)jsonObject error:(NSError **)err
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObject options:0 error:err];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}


/**
 处理类型适配器

 @param jsonObject json对象
 @return 新的json对象
 */
- (id)dealAdapterWithJSONObject:(id)jsonObject
{
    id newJSONObject;
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dict = [jsonObject mutableCopy];
        NSArray *allKey = [dict allKeys];
        NSObject *value;
        for (id key in allKey) {
            value = [dict objectForKey:key];
            
            value = [self dealAdapterWithJSONObject:value];
            if (value != nil) {
                [dict setObject:value forKey:key];
            } else {
                [dict setObject:[NSNull null] forKey:key];
            }
        }
        
        newJSONObject = dict;
    } else if([jsonObject isKindOfClass:[NSArray class]]){
        NSMutableArray *arr = [jsonObject mutableCopy];
        NSObject *element;
        for (NSInteger i = 0; i < arr.count; i ++) {
            element = [arr objectAtIndex:i];
            
            element = [self dealAdapterWithJSONObject:element];
            if (element != nil) {
                [arr replaceObjectAtIndex:i withObject:element];
            } else {
                [arr replaceObjectAtIndex:i withObject:[NSNull null]];
            }
        }
        
        newJSONObject = arr;
        
    } else {
        
        TypeAdapter *adapter = [self getAdapterWithClass:[jsonObject class]];
        if (adapter != nil) {
            newJSONObject = [adapter read:jsonObject];
        } else {
            newJSONObject = jsonObject;
        }
    }
    return newJSONObject;
}

#pragma mark - JSON Parse primitive method

/**
 *  是否JSON支持(对象类型)
 *
 *  @param property_attr 对象属性attribute
 */
- (BOOL)isAllowedJSONObjectTypes:(NSString *)property_attr
{
    BOOL b = NO;
    
    Class allowType;
    for(NSInteger i = 0;i < self.allowedJSONTypes.count;i ++) {
        allowType = [self.allowedJSONTypes objectAtIndex:i];
        if ([property_attr containsString:NSStringFromClass(allowType)]) {
            b = YES;
            break;
        }
    }
    return b;
}


/**
 是否数组类型

 @param property_attr 对象属性attribute
 */
- (BOOL)isArrayType:(NSString *)property_attr
{
    BOOL b = NO;
    if ([property_attr containsString:@"NSArray"] == YES
        || [property_attr containsString:@"NSMutableArray"] == YES ) {
        b = YES;
    }
    return b;
}


/**
 从属性元数据中获取类型

 @param property_attr 属性元数据
 @return 类型
 */
- (Class)getClassFromPropertyAttr:(NSString *)property_attr
{
    Class cls;
    NSArray *strArr = [property_attr componentsSeparatedByString:@"\""];
    if(strArr.count == 3) {
        cls = NSClassFromString([strArr objectAtIndex:1]);
    }
    return cls;
}

/**
 是否基础类型(基础类型)
 
 @param property_attr 对象属性attribute
 */
- (BOOL)property_attrIsPrimitiveType:(NSString *)property_attr
{
    BOOL b = NO;
    
    if ([property_attr containsString:@"@"] == NO) {
        b = YES;
    } else {
        b = NO;
    }
    
    return b;
}


/**
 是否JSON支持的类型
 
 @param property_attr 对象属性attribute
 */
- (BOOL)property_attrJSONArrowType:(NSString *)property_attr
{
    BOOL flag = NO;
    
    BOOL isAllowedJSONOjbectTypes = [self isAllowedJSONObjectTypes:property_attr];
    if (isAllowedJSONOjbectTypes == YES) {
        flag = YES;
    } else {
        BOOL isPrimitive = [self property_attrIsPrimitiveType:property_attr];
        if (isPrimitive == YES) {
            flag = YES;
        } else {
            flag = NO;
        }
    }
    
    return flag;
}

//实体类转化为字典时,如果设置值为nil, 根据传入的null转化类型来设置字典的value值
- (void)setNilWhenBeanParseToDictionary:(NSMutableDictionary *)mutableDict key:(NSString *)key nullParseType:(NullParseType)nullParseType
{
    //nil的转化形式
    if (nullParseType == NullParseTypeDoNotParseWhenNull) {
        //do nothing
    } else if(nullParseType == NullParseTypeAlphabeticString) {
        [mutableDict setObject:[NSString string] forKey:key];
    } else if(nullParseType == NullParseTypeDefautNull) {
        [mutableDict setObject:[NSNull null] forKey:key];
    }
}


/**
 *  获取类型的继承数组
 *
 *  @param cls         类型
 *  @param exceptClass 排除类型
 *
 *  @return 类型的继承数组
 */
+ (NSArray *)getClassArrayWithClass:(Class)cls exceptClass:(Class)exceptClass
{
    //获取对象类型数组
    NSMutableArray *mutableArray = [NSMutableArray array];
    Class superCls = cls;
    //superclass不可以为空
    if (superCls != nil) {
        while ([NSStringFromClass(superCls) isEqualToString:NSStringFromClass(exceptClass)] == NO) {
            [mutableArray addObject:superCls];
            superCls = [superCls superclass];
            
        }
    }
    
    return mutableArray;
}

/**
 *  从 objc_property_t 的attribute中获取对象类型
 *
 *  @return objc_property_t 的attribute中获取对象类型
 */
- (Class)getClassWithPropertyAttribute:(NSString *)property_attr
{
    Class cls;
    NSString *property_attr_copy  = [property_attr  mutableCopy];
    if ([property_attr_copy containsString:@"@"]) {
        NSRange firstRange = [property_attr_copy rangeOfString:@"\""];
        property_attr_copy = [property_attr_copy substringFromIndex:firstRange.location + 1];
        
        if ([property_attr_copy containsString:@"<"]) {
            NSRange lastRange = [property_attr_copy rangeOfString:@"<"];
            property_attr_copy = [property_attr_copy substringToIndex:lastRange.location];
        } else {
            NSRange lastRange = [property_attr_copy rangeOfString:@"\""];
            property_attr_copy = [property_attr_copy substringToIndex:lastRange.location];
        }
        
        if (property_attr_copy) {
            cls = NSClassFromString(property_attr_copy);
        }
    }
    return cls;
}

// 利用反射取得NSObject的属性，并存入到数组中
+ (NSArray *)getPropertyList:(NSArray *)clsArr
{
    NSMutableArray *propertyArray = [NSMutableArray array];
    for(NSInteger i = 0;i < clsArr.count;i ++) {
        Class clazz = [clsArr objectAtIndex:i];
        u_int count;
        objc_property_t *properties = class_copyPropertyList(clazz, &count);
        for (int i = 0; i < count ; i++)
        {
            const char* propertyName = property_getName(properties[i]);
            [propertyArray addObject: [NSString stringWithUTF8String: propertyName]];
        }
        free(properties);
    }
    
    return propertyArray;
}



#pragma mark - json assistant method

/**
 *  检测并转化字符串中的特殊字符
 *
 *  @param str 字符串
 *
 *  @return 转化后的字符串
 */
- (NSString *)detectAndExchangeSpecialCharWithString:(NSString *)str
{
    NSString *specialChar1 = @"\\/";
    NSString *replaceChar1 = @"/";
    NSString *newStr = str;
    if ([str containsString:specialChar1] == YES) {
        newStr = [str stringByReplacingOccurrencesOfString:specialChar1 withString:replaceChar1];
    }
    
    return newStr;
}

/**
 *  在转化成JSON对象前,把json字符串中的特殊转义符号做出替换
 *
 *  @param str json字符串
 *
 *  @return 替换后的json字符串
 */
- (NSString *)detectAndExchangeSpecialCharWithStringBeforeExchangeToJSONObjectWithStr:(NSString *)jsonString
{
    NSString *str = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    
    return str;
}

/**
 *  是否日期
 *
 *  @return 是否日期格式/时间
 */
- (BOOL)isDateFormat:(NSString *)dateStr
{
    BOOL b = NO;
    if (dateStr) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = self.dateFormat;
        NSDate *date = [dateFormat dateFromString:dateStr];
        
        if (date != nil) {
            b = YES;
        }
    }
    return b;
}

//是否时间格式
- (BOOL)isDatetimeFormat:(NSString *)dateStr
{
    BOOL b = NO;
    if (dateStr) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        dateFormat.dateFormat = self.datetimeFormat;
        NSDate *date2 = [dateFormat dateFromString:dateStr];
        
        if (date2 != nil) {
            b = YES;
        }
    }
    return b;
}

#pragma mark - type adapter

/**
 获取适配器

 @param cls 类
 @return 对应的适配器
 */
- (TypeAdapter *)getAdapterWithClass:(Class)cls
{
    TypeAdapter *adp;
    //暂时只支持对字符串进行适配
    if([NSStringFromClass(cls) containsString:@"String"]) {
        cls = [NSString class];
    }
    
    adp = [self.adapterDict objectForKey:NSStringFromClass(cls)];
    return adp;
}


#pragma mark - copy bean

//复制源BEAN中不为空的值给目标BEAN
+ (void)copyBeanToBean:(NSObject *)sourceObj targetObj:(NSObject *)targetObj classArray:(NSArray *)clsArr
{
    //迭代所有类的属性
    if (clsArr && clsArr.count > 0) {
        unsigned int j;
        for( j = 0;j < clsArr.count;j ++) {
            unsigned int outCount;
            unsigned int i;
            Class curCls = [clsArr objectAtIndex:j];
            objc_property_t *properties = class_copyPropertyList(curCls, &outCount);
            for (i = 0; i < outCount; i ++) {
                objc_property_t property = properties[i];
                NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                SEL selGet = NSSelectorFromString(key);
                
                if (targetObj && [targetObj respondsToSelector:selGet]) {
                    NSObject *valObj = [sourceObj valueForKey:key];
                    //NSDctionary的值不能为nil
                    if (valObj != nil) {
                        [targetObj setValue:valObj forKey:key];
                    }
                }
            }
            free(properties);
        }
    }
}

+ (void)copyBeanToBean:(NSObject *)sourceObj targetObj:(NSObject *)targetObj
{
    NSArray *clsArr = [APBeanParser getClassArrayWithClass:[sourceObj class] exceptClass:[NSObject class]];
    [APBeanParser copyBeanToBean:sourceObj targetObj:targetObj classArray:clsArr];
}

#pragma mark - Public Methods  NSString && NSDate parse methods

//是否是PHP格式的date
+ (BOOL)isPHPNSDate:(NSString *)dateStr
{
    if (dateStr && dateStr.length > (APBeanParserPHPDatePrefix.length + APBeanParserPHPDateSuffix.length)) {
        BOOL b1 = [[dateStr substringToIndex:APBeanParserPHPDatePrefix.length] isEqualToString:APBeanParserPHPDatePrefix];
        BOOL b2 = [[dateStr substringFromIndex:(dateStr.length - APBeanParserPHPDateSuffix.length)] isEqualToString:APBeanParserPHPDateSuffix];
        return (b1 && b2);
    }
    return NO;
}

// 转化时间戳为日期对象 固定格式：/Date(1394259720000)/
+ (NSDate *)changePHPToNSDate:(NSString *)date withFormatter:(NSString *)format
{
    NSDate *pDate = nil;
    date = [NSString stringWithFormat:@"%@", date];
    if (date && [date isEqualToString:@"<null>"] == NO) {

        date = [date stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
        date = [date stringByReplacingOccurrencesOfString:@")/" withString:@""];
        date = [date substringToIndex:10];
        
        pDate = [NSDate dateWithTimeIntervalSince1970:[date intValue]];
    }
    return pDate;
}

//时间格式化为字符串
+ (NSString *)dateToString:(NSDate *)date withFormatter:(NSString *)format
{
    NSString *str = @"";
    if ([APBeanParser isNotBlank:date] && [APBeanParser isNotBlank:format]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = format;
        str = [df stringFromDate:date];
    }
    return str;
}

//字符串转日期
+ (NSDate *)stringToDate:(NSString *)string withFormatter:(NSString *)format
{
    NSDate *date = nil;
    if ([APBeanParser isNotBlank:string] && [APBeanParser isNotBlank:format]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = format;
        date = [df dateFromString:string];
    }
    return date;
}

//获取NSDateComponents, 通过他可以获取年月日时分秒
+ (NSDateComponents *)getNSDateComponentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    return comps;
}

//判断是否不为空
//支持 NSString, NSDate
+ (BOOL)isNotBlank:(NSObject *)obj
{
    if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        if (str != nil && str.length != 0) {
            return YES;
        }
    } else {
        if (obj) {
            return YES;
        }
    }
    return NO;
}

//默认字符串转日期
- (NSDate *)stringToDefaultDate:(NSString *)string
{
    return [APBeanParser stringToDate:string withFormatter:self.dateFormat];
}

//默认字符串转日期时间
- (NSDate *)stringToDefaultDatetime:(NSString *)string
{
    return [APBeanParser stringToDate:string withFormatter:self.datetimeFormat];
}

//默认日期转换字符串
- (NSString *)dateToDefaultString:(NSDate *)date
{
    return [APBeanParser dateToString:date withFormatter:self.datetimeFormat];
}

//默认日期时间转换字符串
- (NSString *)datetimeToDefaultString:(NSDate *)date
{
    return [APBeanParser dateToString:date withFormatter:self.datetimeFormat];
}


@end
