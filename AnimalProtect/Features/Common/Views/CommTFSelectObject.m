//
//  CommTFSlelectObject.m
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CommTFSelectObject.h"

@implementation CommTFSelectObject

+ (instancetype)objWithCode:(NSString *)code name:(NSString *)name
{
    CommTFSelectObject *obj = [[CommTFSelectObject alloc] init];
    obj.CODE = code;
    obj.NAME = name;
    return obj;
}

@end
