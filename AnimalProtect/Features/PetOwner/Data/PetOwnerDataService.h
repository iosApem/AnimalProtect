//
//  PetOwnerDataService.h
//  AnimalProtect
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APDataService.h"
#import "CLPetDog.h"
#import "CLNews.h"

/**
 宠物主数据服务
 */
@interface PetOwnerDataService : APDataService

- (void)requestNewsList:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail;

- (void)requestWithNewsID:(NSString *)newsID succ:(void(^)(CLNews *news))succ fail:(APDataServiceFailBlock)fail;
@end
