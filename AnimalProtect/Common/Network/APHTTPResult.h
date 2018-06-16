//
//  APHTTPResult.h
//  AnimalProtect
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModelLib.h"

/**
 请求结果
 */
@interface APHTTPResult : JSONModel

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *message;

@end
