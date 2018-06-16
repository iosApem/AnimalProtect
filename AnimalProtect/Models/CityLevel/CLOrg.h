//
//  CLOrg.h
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommTFSelectObject.h"

/**
 机构
 
 @author apem
 */
@interface CLOrg : NSObject

@property (nonatomic, strong) NSString *CODE;
@property (nonatomic, strong) NSString *NAME;
@property (nonatomic, strong) NSString *PARENT_CODE;

+ (NSArray<CommTFSelectObject *> *)selectObjectArrWithArr:(NSArray<CLOrg *> *)arr;

@end
