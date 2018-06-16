//
//  APHTTPRequest.m
//  AnimalProtect
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APHTTPRequest.h"

@interface APHTTPRequest()

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation APHTTPRequest

- (instancetype)initWithTask:(NSURLSessionDataTask *)task
{
    if (self = [super init]) {
        self.task = task;
    }
    return self;
}

- (void)cancel
{
    [self.task cancel];
}

@end
