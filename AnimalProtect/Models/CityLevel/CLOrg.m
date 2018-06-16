//
//  CLOrg.m
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLOrg.h"

@implementation CLOrg

+ (NSArray<CommTFSelectObject *> *)selectObjectArrWithArr:(NSArray<CLOrg *> *)arr
{
    NSMutableArray *selectArr = [NSMutableArray array];
    for (CLOrg *dict in arr) {
        CommTFSelectObject *seleObj = [CommTFSelectObject objWithCode:dict.CODE name:dict.NAME];
        seleObj.data = dict;
        [selectArr addObject:seleObj];
    }
    return selectArr;
}

@end
