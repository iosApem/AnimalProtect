//
//  CLSysDict.h
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommTFSelectObject.h"

@class CLSysDict;

//字典类型
typedef NSString *CLSysDictType;
static CLSysDictType CLSysDictTypePetKind = @"犬种信息";
static CLSysDictType CLSysDictTypeVaccineFactory = @"疫苗厂家";
static CLSysDictType CLSysDictTypeVaccineKind = @"疫苗种类";


/**
 字典
 
 @author apem
 */
@interface CLSysDict : NSObject

@property (nonatomic, strong) NSString *CODE;
@property (nonatomic, strong) NSString *NAME;

+ (NSArray<CommTFSelectObject *> *)selectObjectArrWithArr:(NSArray<CLSysDict *> *)arr;

@end
