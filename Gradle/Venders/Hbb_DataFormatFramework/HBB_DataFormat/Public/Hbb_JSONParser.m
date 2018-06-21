//
//  Hbb_JSONParser.m
//  HBB_DataFormatDemo
//
//  Created by CHENG DE LUO on 15/7/30.
//  Copyright (c) 2015年 CHENG DE LUO. All rights reserved.
//

#import "Hbb_JSONParser.h"
#import "APBeanParser.h"
#import "NSArray+DateString.h"
#import "NSDictionary+DateString.h"
#import "NSArray+DateString.h"
#import "HBFormatErrorDearler.h"

@interface Hbb_JSONParser ()

@property (nonatomic, strong) APBeanParser *apBeanParser;
@property (nonatomic, strong) NSMutableDictionary *adapterDict;
@property (nonatomic, strong) HBFormatErrorDearler *errDealer;

@end

@implementation Hbb_JSONParser

- (void)registerTypeAdapter:(TypeAdapter *)adapter cls:(Class)cls
{
    if (adapter != nil && cls != nil) {
        [self.adapterDict setObject:adapter forKey:NSStringFromClass(cls)];
    } else {
        NSLog(@"%s:类型适配器参数不完整", __func__);
    }
}

- (void)registerErrDealer:(HBFormatErrorDearler *)errDealer
{
    if (errDealer != nil) {
        self.errDealer = errDealer;
    } else {
        NSLog(@"%s:错误处理器参数不完整", __func__);
    }
}

- (void)setDateFormat:(NSString *)dateFormat
{
    _dateFormat = dateFormat;
    self.apBeanParser.dateFormat = _dateFormat;
}

- (void)setDatetimeFormat:(NSString *)datetimeFormat
{
    _datetimeFormat = datetimeFormat;
    self.apBeanParser.datetimeFormat = _datetimeFormat;
}

- (void)setNullParseType:(Hbb_JSONParserNullParseType)nullParseType
{
    _nullParseType = nullParseType;
    self.apBeanParser.nullParseType = (NullParseType)_nullParseType;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.datetimeFormat = @"yyyy-MM-dd HH:mm:ss";
        self.dateFormat = @"yyyy-MM-dd";
        self.nullParseType = Hbb_JSONParserNullParseTypeDefautNull;
        
        self.adapterDict = [NSMutableDictionary dictionary];
        
        self.apBeanParser = [[APBeanParser alloc] init];
        self.apBeanParser.dateFormat = self.dateFormat;
        self.apBeanParser.datetimeFormat = self.datetimeFormat;
        self.apBeanParser.nullParseType = (NullParseType)self.nullParseType;
        
        self.apBeanParser.adapterDict = self.adapterDict;
        
        self.errDealer = [[HBFormatErrorDearler alloc] init];
        self.apBeanParser.errDealer = self.errDealer;
        
    }
    return self;
}

- (id)jsonStringToBean:(NSString *)jsonString cls:(Class)cls
{
    id bean;
    if (jsonString != nil && [jsonString isEqualToString:@""] == NO) {
        NSDictionary *dict = [self jsonStringToDictionary:jsonString];
        NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
        
        bean = [self.apBeanParser parseToBean:dict toClassArray:clsArray];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:jsonString:%@", HBFormatErrorDescParamNil, __func__, jsonString];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return bean;
}

- (NSArray *)jsonStringToBeanArray:(NSString *)jsonString cls:(Class)cls
{
    NSArray *beanArray;
   if (jsonString != nil && [jsonString isEqualToString:@""] == NO) {
       NSArray *dictArray = [self.apBeanParser jsonStringToDictionaryArray:jsonString];
       NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
       
       beanArray = [self.apBeanParser parseToBeanArr:dictArray toClassArray:clsArray];
   } else {
       NSString *log = [NSString stringWithFormat:@"%@:%s:jsonString:%@", HBFormatErrorDescParamNil, __func__, jsonString];
       NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
       [self.errDealer dealWtihFormatError:err];
   }
    
    return beanArray;
}

- (NSString *)beanToJsonString:(NSObject *)bean
{
    NSString *jsonString;
    if (bean != nil) {
        NSArray *clsArray = [self getClassArrayWithClass:[bean class] exceptClass:[NSObject class]];
        
        jsonString = [self.apBeanParser beanToString:bean classArray:clsArray];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:bean:%@", HBFormatErrorDescParamNil, __func__, bean];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return jsonString;
}
- (NSString *)beanArrayToJsonString:(NSArray *)beanArray cls:(Class)cls
{
    NSString *string;
    if (beanArray != nil) {
        NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
        
        string = [self.apBeanParser beanArrToString:beanArray classArray:clsArray];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:beanArray:%@", HBFormatErrorDescParamNil, __func__, beanArray];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return string;
}

- (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString
{
    NSDictionary *dict;
    if (jsonString != nil && [jsonString isEqualToString:@""] == NO) {
        dict = [self.apBeanParser jsonStringToDictionary:jsonString];
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
        arr = [self.apBeanParser jsonStringToDictionaryArray:jsonString];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:jsonString:%@", HBFormatErrorDescParamNil, __func__, jsonString];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    return arr;
}

- (NSString *)dictionaryToJsonString:(NSDictionary *)dictionary
{
    NSString *string;
    if (dictionary != nil) {
        string = [self.apBeanParser dictionaryToString:dictionary];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:dictionary:%@", HBFormatErrorDescParamNil, __func__, dictionary];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    return string;
}

- (NSString *)dictionaryArrayToJsonString:(NSArray *)dictionaryArray
{
    return [self.apBeanParser dictionaryArrayToJsonString:dictionaryArray];
}

- (NSDictionary *)beanToDictionary:(NSObject *)bean
{
    NSDictionary *dictionary;
    if (bean != nil) {
        NSArray *clsArray = [self getClassArrayWithClass:[bean class] exceptClass:[NSObject class]];
        
        dictionary = [self.apBeanParser beanToDictionary:bean classArray:clsArray];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:bean:%@", HBFormatErrorDescParamNil, __func__, bean];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return dictionary;
}

- (id)dictionaryToBean:(NSDictionary *)dictionary cls:(Class)cls
{
    id bean;
    if (dictionary != nil) {
        NSArray *clsArray = [self getClassArrayWithClass:cls exceptClass:[NSObject class]];
        bean = [self.apBeanParser parseToBean:dictionary toClassArray:clsArray];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:dictionary:%@", HBFormatErrorDescParamNil, __func__, dictionary];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return bean;
}

- (NSArray *)beanArrayToDictionaryArray:(NSArray *)beanArray
{
    NSMutableArray *mutableArray;
    if (beanArray != nil) {
       mutableArray = [NSMutableArray array];
        NSDictionary *dict;
        for (id bean in beanArray) {
            dict = [self beanToDictionary:bean];
            if(dict) {
                [mutableArray addObject:dict];
            }
            
        }
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:beanArray:%@", HBFormatErrorDescParamNil, __func__, beanArray];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return mutableArray;
}

- (NSArray *)dictionaryArrayToBeanArray:(NSArray *)dictionaryArray cls:(Class)cls
{
    NSMutableArray *mutableArray;
    if (dictionaryArray != nil) {
        mutableArray = [NSMutableArray array];
        NSObject *obj;
        for (NSDictionary *dict in dictionaryArray) {
            obj = [self dictionaryToBean:dict cls:cls];
            if (obj) {
                [mutableArray addObject:obj];
            }
        }
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:dictionaryArray:%@", HBFormatErrorDescParamNil, __func__, dictionaryArray];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    
    return mutableArray;
}

- (NSArray *)arrayToJSONObjectArray:(NSArray *)array
{
    NSArray *arr;
    if (array != nil) {
        arr = [self.apBeanParser arrayToJSONObjectArray:array];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:array:%@", HBFormatErrorDescParamNil, __func__, array];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    return arr;
}

- (NSString *)arrayToJSONString:(NSArray *)array
{
    NSString *string;
    if (array != nil) {
        string = [self.apBeanParser arrayToJSONString:array];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:array:%@", HBFormatErrorDescParamNil, __func__, array];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    return string;
}

- (NSString *)objectToJsonString:(id)object
{
    NSString *string;
    if (object != nil) {
        string = [self.apBeanParser objectToJsonString:object];
    } else {
        NSString *log = [NSString stringWithFormat:@"%@:%s:object:%@", HBFormatErrorDescParamNil, __func__, object];
        NSError *err = [NSError errorWithDomain:log code:HBFormatErrorCodeParamNil userInfo:nil];
        [self.errDealer dealWtihFormatError:err];
    }
    return string;
}

#pragma mark - private methods

/**
 *  获取类型的继承数组
 *
 *  @param cls         类型
 *  @param exceptClass 排除类型
 *
 *  @return 类型的继承数组
 */
- (NSArray *)getClassArrayWithClass:(Class)cls exceptClass:(Class)exceptClass
{
    //获取对象类型数组
    NSMutableArray *mutableArray = [NSMutableArray array];
    Class superCls = cls;
    while (![NSStringFromClass(superCls) isEqualToString:NSStringFromClass(exceptClass)]) {
        [mutableArray addObject:superCls];
        superCls = [superCls superclass];
    }
    return mutableArray;
}

@end
