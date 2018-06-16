//
//  APHTTPRequest.h
//  AnimalProtect
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APHTTPRequest.h"

@interface APHTTPRequest : NSObject

- (instancetype)initWithTask:(NSURLSessionDataTask *)task;

- (void)cancel;

@end
