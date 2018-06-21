//
//  APDataService.m
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APDataService.h"

@implementation APDataService

- (instancetype)init
{
    if (self = [super init]) {
        self.jsonParser = [[Hbb_JSONParser alloc] init];
    }
    return self;
}

@end
