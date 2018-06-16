//
//  CLSysDict.m
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLSysDict.h"

@implementation CLSysDict

+ (NSArray<CommTFSelectObject *> *)selectObjectArrWithArr:(NSArray<CLSysDict *> *)arr
{
    NSMutableArray *selectArr = [NSMutableArray array];
    for (CLSysDict *dict in arr) {
        CommTFSelectObject *seleObj = [CommTFSelectObject objWithCode:dict.CODE name:dict.NAME];
        seleObj.data = dict;
        [selectArr addObject:seleObj];
    }
    return selectArr;
}
@end
