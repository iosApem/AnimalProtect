//
//  APUsers.h
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

//用户类型
typedef enum {
    APUsersTypePetOwner = 0x00,
    APUsersTypeCityLevel = 0x01,
}APUsersType;

/**
 用户
 @author apem
 */
@interface APUsers : NSObject

@property (nonatomic, strong) NSString *UserID;
@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *PWD;
@property (nonatomic, strong) NSString *verifyCode;

@property (nonatomic, assign) APUsersType userType; //用户类型


/**
 单例用于存储当前用户

 @return 当前用户
 */
+ (instancetype)currentUser;

+ (void)setCurrentUser:(APUsers *)user;

@end
