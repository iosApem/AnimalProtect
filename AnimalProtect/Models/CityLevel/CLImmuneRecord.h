//
//  CLImmuneRecord.h
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 市级免疫记录
 
 @author apem
 */
@interface CLImmuneRecord : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *immuneNo;
@property (nonatomic, strong) NSString *ownerNo;
@property (nonatomic, strong) NSString *immuneTime;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *latitude;

@property (nonatomic, strong) NSString *ownerName;
@property (nonatomic, strong) NSString *dogNo;
@property (nonatomic, strong) NSString *dogName;

@property (nonatomic, strong) NSString *vaccineKind;
@property (nonatomic, strong) NSString *vaccineQty;
@property (nonatomic, strong) NSString *immunityQty;
@property (nonatomic, strong) NSString *vaccineFactory;
@property (nonatomic, strong) NSString *vaccineBatch;
@property (nonatomic, strong) NSString *resistDate;
@property (nonatomic, strong) NSString *comments;

@property (nonatomic, strong) NSString *orgCode;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *village;
@property (nonatomic, strong) NSString *orgName;

@end
