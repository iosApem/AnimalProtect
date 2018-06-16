//
//  PetDog.h
//  AnimalProtect
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 宠物狗
 */
@interface CLPetDog : NSObject

@property (nonatomic, strong) NSString *id;    //ID
@property (nonatomic, strong) NSString *dogNo; //犬编号
@property (nonatomic, strong) NSString *name;  //犬种类型
@property (nonatomic, strong) NSString *age;   //年龄
@property (nonatomic, strong) NSString *weight;//体重
@property (nonatomic, strong) NSString *looks; //外貌

@property (nonatomic, strong) NSString *comments;//备注
@property (nonatomic, strong) NSString *ownerNo; //犬主

@end
