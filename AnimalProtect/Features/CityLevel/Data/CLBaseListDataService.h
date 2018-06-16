//
//  CLBaseListDataService.h
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APDataService.h"
#import "CLOrg.h"
#import "CLSysDict.h"

/**
 基础资料数据服务
 
 @author apem
 */
@interface CLBaseListDataService : APDataService

//获取字典
- (void)getCLSysDictWithType:(CLSysDictType)type succ:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail;

//获取机构
- (void)getCLOrgWithParentCode:(NSString *)parentCode succ:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail;

@end
