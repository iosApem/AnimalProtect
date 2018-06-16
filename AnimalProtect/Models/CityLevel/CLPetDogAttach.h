//
//  PetDogAttach.h
//  AnimalProtect
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 宠物狗附件
 
 @author apem
 */
@interface CLPetDogAttach : NSObject

@property (nonatomic, strong) NSString *id;    //ID
@property (nonatomic, strong) NSString *dogNo;
@property (nonatomic, strong) NSNumber *idx;
@property (nonatomic, strong) NSData *content;
@property (nonatomic, strong) NSString *fileType;
@property (nonatomic, strong) NSString *fileName;

@end
