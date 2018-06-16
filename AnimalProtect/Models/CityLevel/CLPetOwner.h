//
//  CLPetOwner.h
//  AnimalProtect
//
//  Created by apple on 2018/5/13.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 宠物主信息
 
 @author apem
 */
@interface CLPetOwner : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *ownerNo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *orgCode;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSString *orgName;
@property (nonatomic, strong) NSString *isAudit;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *village;
@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, strong) NSString *password;

@end
