//
//  APHTTPResult.h
//  AnimalProtect
//
//  Created by apple on 2018/5/21.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 请求结果
 */
@interface APHTTPResult : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) id data;

@end
