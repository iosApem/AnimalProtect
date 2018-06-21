//
//  RLLoginService.m
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "RLLoginService.h"

@implementation RLLoginService

- (void)loginWithUsers:(APUsers *)users succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    
//    self.baseURL = @"http://183.6.182.162:7070/aedp/sys/Login.action?userName=admin&password=admin"
    
    NSError *err = [self validateLoginUser:users];
    if (err == nil) {
        __block APUsers *block_user = users;
        
        NSDictionary *dict = @{@"userName": (users.UserName ?: @""), @"password": (users.PWD ?: @"")};
        [[APHTTPSession sharedSession] httpGETWithKey:api_key_core_LoginJson_action param:dict progress:nil succ:^(id responseObject) {
            
            APHTTPResult *rs = [self.jsonParser jsonStringToBean:responseObject cls:[APHTTPResult class]];
            
            if (rs.success == YES) {
                NSDictionary *dataDict = rs.data;
                if (dataDict != nil) {
                    block_user = [self.jsonParser dictionaryToBean:dataDict cls:[APUsers class]];
                }
                [APUsers setCurrentUser:block_user];
                
                if (succ) {
                    succ();
                }
            } else {
                NSError *error = [NSError errorWithDomain:rs.message code:-1 userInfo:nil];
                if(fail) fail(error);
            }
            
        } fail:^(NSError *error) {
            if(fail) fail(error);
        }];
    } else {
        if(fail) fail(err);
    }
}

- (void)requestVerCodeWithSucc:(void(^)(NSString *verifyCode))succ fail:(APDataServiceFailBlock)fail
{
    int x = arc4random() % 10000;
    NSString *verfyCode = [NSString stringWithFormat:@"%d", x];
    succ(verfyCode);
}

/**
 验证登录的用户数据的完整性
 
 @param users user对象
 @return 返回nil说明成功
 */
- (NSError *)validateLoginUser:(APUsers *)users
{
    BOOL flag = YES;
    NSString *desc = @"";
    NSError *error;
    if ([NSString notBlank:users.UserName] == NO) {
        flag = NO;
        desc = @"请输入用户名";
    } else if([NSString notBlank:users.PWD] == NO){
        flag = NO;
        desc = @"请输入密码";
    }
    
    if (flag == NO) {
        error = [NSError errorWithDomain:desc code:-1 userInfo:nil];
    }
    return error;
}

@end
