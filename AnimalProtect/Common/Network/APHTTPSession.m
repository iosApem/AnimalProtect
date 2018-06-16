//
//  APHTTPSession.m
//  AnimalProtect
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APHTTPSession.h"
#import "AFNetworking.h"

@interface APHTTPSession()

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) AFHTTPSessionManager *session;

@end

@implementation APHTTPSession

- (instancetype)init
{
    if (self = [super init]) {
        self.session = [AFHTTPSessionManager manager];
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.session.requestSerializer.timeoutInterval = 5;

        self.baseURL = @"http://183.6.182.162:7070/aedp";
//        self.baseURL = @"https://www.baidu.com";
    }
    return self;
}

+ (instancetype)sharedSession
{
    APHTTPSession *sesion = [[APHTTPSession alloc] init];    
    return sesion;
}

- (APHTTPRequest *)httpGETWithKey:(NSString *)key param:(NSDictionary *)param progress:(void(^)(NSProgress *prog))progress succ:(void(^)(id responseObject))succ fail:(void(^)(NSError *error))fail
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", self.baseURL, key ?: @""];
    
    NSURLSessionDataTask *task = [self.session GET:url parameters:param progress:^(NSProgress * downloadProgress) {
        
        if(progress) {
            progress(downloadProgress);
        }
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        if (str != nil && [str isEqualToString:@"null"] == NO) {
            
            if(succ) {
                succ(str);
            }
            
        } else {
            NSError *error = [NSError errorWithDomain:@"返回数据不合法" code:-1 userInfo:nil];
            if(fail) fail(error);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        if (fail) {
            fail(error);
        }
        
    }];
    
    APHTTPRequest *request = [[APHTTPRequest alloc] initWithTask:task];
    
    return request;
}

- (APHTTPRequest *)httpPOSTWithKey:(NSString *)key param:(NSDictionary *)param progress:(void(^)(NSProgress *prog))progress succ:(void(^)(id responseObject))succ fail:(void(^)(NSError *error))fail;
{
    return nil;
}

@end
