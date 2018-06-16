//
//  CLBaseListDataService.m
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLBaseListDataService.h"

@implementation CLBaseListDataService

- (void)getCLSysDictWithType:(CLSysDictType)type succ:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSDictionary *dict = @{@"dictType": type};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_sys_SysDictFindJson_action param:dict progress:nil succ:^(id responseObject) {
        
        NSArray *arr = [CLSysDict mj_objectArrayWithKeyValuesArray:responseObject];
        if (succ) {
            succ(arr);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)getCLOrgWithParentCode:(NSString *)parentCode succ:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSDictionary *dict = @{@"parentCode": parentCode ?: @""};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_sys_FindOrg_action param:dict progress:nil succ:^(id responseObject) {
        
        NSArray *arr = [CLOrg mj_objectArrayWithKeyValuesArray:responseObject];
        if (succ) {
            succ(arr);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

@end
