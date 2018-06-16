//
//  CityLevelDataService.h
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APDataService.h"
#import "CLImmuneRecord.h"
#import "CLPetOwner.h"
#import "CLPetDog.h"

/**
 市级数据服务
 */
@interface CityLevelDataService : APDataService

//根据宠物主ID获取免疫记录列表
- (void)requestImmuneListWithOwnerNo:(NSString *)ownerNo succ:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail;

//获取单个免疫记录
- (void)requestImmuneWithId:(NSString *)ID succ:(void(^)(CLImmuneRecord *record))succ fail:(APDataServiceFailBlock)fail;

//提交免疫记录
- (void)requestSubmitImmune:(CLImmuneRecord *)record succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail;

//获取市镇宠物主列表
- (void)requestPetOwnerListWithSucc:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail;

//请求犬主审核列表
- (void)requestCheckListWithSucc:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail;

//请求犬主审核详情
- (void)requestCheckWithOwnerNo:(NSString *)ownerNo succ:(void(^)(CLPetOwner *owner))succ fail:(APDataServiceFailBlock)fail;

//提交审核详情
- (void)requestSubmitCheck:(CLPetOwner *)owner succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail;

//请求犬主信息
- (void)requestPetOwnerWithID:(NSString *)ID succ:(void(^)(CLPetOwner *owner))succ fail:(APDataServiceFailBlock)fail;

//保存犬主
- (void)requestSubmitPetOwner:(CLPetOwner *)owner succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail;

//请求宠物主的宠物列表
- (void)requestPetListWithOwnerNo:(NSString *)ownerNo succ:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail;

//请求宠物信息
- (void)requestPetInfoWithID:(NSString *)dogID succ:(void(^)(CLPetDog *dog))succ fail:(APDataServiceFailBlock)fail;

//请求提交宠物信息
- (void)requestSubmitDogInfo:(CLPetDog *)dog succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail;


@end
