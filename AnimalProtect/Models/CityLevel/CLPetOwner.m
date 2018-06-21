//
//  CLPetOwner.m
//  AnimalProtect
//
//  Created by apple on 2018/5/13.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLPetOwner.h"

@implementation CLPetOwner

+ (NSArray<CommTFSelectObject *> *)dictArrayWithArray:(NSArray<CLPetOwner *> *)ownerArray;
{
    NSMutableArray *arr = [NSMutableArray array];
    CLPetOwner *owner;
    CommTFSelectObject *obj;
    for (NSInteger i = 0;i < ownerArray.count; i ++) {
        owner = [ownerArray objectAtIndex:i];
        obj = [[CommTFSelectObject alloc] init];
        obj.CODE = owner.ownerNo;
        obj.NAME = owner.name;
        obj.data = owner;
        
        [arr addObject:obj];
    }
    return arr;
}

@end
