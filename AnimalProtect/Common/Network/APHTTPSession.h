//
//  APHTTPSession.h
//  AnimalProtect
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APHTTPRequest.h"

/**
 HTTP请求会话
 
 @author apem
 */
@interface APHTTPSession : NSObject

/**
 通用HTTP请求会话
 */
+ (instancetype)sharedSession;

/**
 GET请求

 @param key 请求key
 @param param 请求参数
 @param progress 进度
 @param succ 成功回调
 @param fail 失败回调
 @return 请求对象
 */
- (APHTTPRequest *)httpGETWithKey:(NSString *)key param:(NSDictionary *)param progress:(void(^)(NSProgress *prog))progress succ:(void(^)(id responseObject))succ fail:(void(^)(NSError *error))fail;


/**
 POST请求 (暂未启用)
 
 @param key 请求key
 @param param 请求参数
 @param progress 进度
 @param succ 成功回调
 @param fail 失败回调
 @return 请求对象
 */
- (APHTTPRequest *)httpPOSTWithKey:(NSString *)key param:(NSDictionary *)param progress:(void(^)(NSProgress *prog))progress succ:(void(^)(id responseObject))succ fail:(void(^)(NSError *error))fail;

@end
