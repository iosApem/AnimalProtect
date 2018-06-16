//
//  APUsers.m
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APUsers.h"

static APUsers *static_APUsers;

@implementation APUsers

+ (instancetype)currentUser
{
    if (static_APUsers == nil) {
        static_APUsers = [[APUsers alloc] init];
    }
    return static_APUsers;
}

+ (void)setCurrentUser:(APUsers *)user
{
    static_APUsers = user;
}

@end
