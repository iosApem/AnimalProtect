//
//  RLLoginService.h
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APDataService.h"
#import "APUsers.h"

/**
 登录注册服务
 */
@interface RLLoginService : APDataService

- (void)loginWithUsers:(APUsers *)users succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail;

- (void)requestVerCodeWithSucc:(void(^)(NSString *verifyCode))succ fail:(APDataServiceFailBlock)fail;

@end
