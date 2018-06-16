//
//  CityLevelDataService.m
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CityLevelDataService.h"

@implementation CityLevelDataService

- (void)requestImmuneListWithOwnerNo:(NSString *)ownerNo succ:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSDictionary *searchDict;
    NSDictionary *dict;
    if (ownerNo != nil) {
        searchDict = @{@"ownerNo": ownerNo ?: @""};
         dict = @{@"data": [searchDict mj_JSONString]};
    } else {
        dict = nil;
    }
   
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_dog_DogOwnerImmuneJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLImmuneRecord mj_objectArrayWithKeyValuesArray:responseObject];
            
            succ(arr);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestImmuneWithId:(NSString *)ID succ:(void(^)(CLImmuneRecord *record))succ fail:(APDataServiceFailBlock)fail
{
    NSDictionary *searchDict = @{@"id": ID ?: @""};
    NSDictionary *dict = @{@"data": [searchDict mj_JSONString]};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_dog_DogOwnerImmuneJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLPetOwner mj_objectArrayWithKeyValuesArray:responseObject];
            
            CLImmuneRecord *recrod = [arr firstObject];
            succ(recrod);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestSubmitImmune:(CLImmuneRecord *)record succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSString *jsonstring = [record mj_JSONString];
    NSDictionary *dict = @{@"data": jsonstring};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_dog_DogOwnerImmuneSaveByJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            succ();
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestPetOwnerListWithSucc:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSDictionary *dict = @{@"data": @"{}"};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_DogOwnerJson_action param:dict progress:nil succ:^(id responseObject) {
        
            if (succ) {
                NSArray *arr = [CLPetOwner mj_objectArrayWithKeyValuesArray:responseObject];
                succ(arr);
            }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
    
}


- (void)requestCheckListWithSucc:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    
    NSDictionary *searchDict = @{@"isAudit": @"N"};
    NSDictionary *dict = @{@"data": [searchDict mj_JSONString]};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_DogOwnerJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLPetOwner mj_objectArrayWithKeyValuesArray:responseObject];
            succ(arr);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
    
}

- (void)requestCheckWithOwnerNo:(NSString *)ownerNo succ:(void(^)(CLPetOwner *owner))succ fail:(APDataServiceFailBlock)fail
{
    NSDictionary *searchDict = @{@"isAudit": @"N", @"ownerNo": ownerNo ?: @""};
    NSDictionary *dict = @{@"data": [searchDict mj_JSONString]};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_DogOwnerJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLPetOwner mj_objectArrayWithKeyValuesArray:responseObject];
            succ([arr firstObject]);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestSubmitCheck:(CLPetOwner *)owner succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    owner.isAudit = @"Y";
    NSString *jsonstring = [owner mj_JSONString];
    NSDictionary *dict = @{@"data": jsonstring};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_DogOwnerSaveByJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            succ();
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestPetOwnerWithID:(NSString *)ID succ:(void(^)(CLPetOwner *owner))succ fail:(APDataServiceFailBlock)fail
{
    NSDictionary *searchDict = @{@"id": ID ?: @""};
    NSDictionary *dict = @{@"data": [searchDict mj_JSONString]};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_DogOwnerJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLPetOwner mj_objectArrayWithKeyValuesArray:responseObject];
            
            CLPetOwner *owner = [arr firstObject];
            succ(owner);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
    
}

- (void)requestSubmitPetOwner:(CLPetOwner *)owner succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSString *jsonstring = [owner mj_JSONString];
    NSDictionary *dict = @{@"data": jsonstring};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_DogOwnerSaveByJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            succ();
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestPetListWithOwnerNo:(NSString *)ownerNo succ:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSDictionary *searchDict;
    if (ownerNo != nil) {
        searchDict = @{@"ownerNo": ownerNo ?: @""};
    } else {
        searchDict = @{};
    }
    
    NSDictionary *dict = @{@"data": [searchDict mj_JSONString]};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_dog_DogOwnerDogJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLPetDog mj_objectArrayWithKeyValuesArray:responseObject];
            
            succ(arr);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestPetInfoWithID:(NSString *)dogID succ:(void(^)(CLPetDog *dog))succ fail:(APDataServiceFailBlock)fail;
{
    NSDictionary *searchDict = @{@"id": dogID ?: @""};
    NSDictionary *dict = @{@"data": [searchDict mj_JSONString]};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_dog_DogOwnerDogJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLPetDog mj_objectArrayWithKeyValuesArray:responseObject];
            
            succ([arr firstObject]);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestSubmitDogInfo:(CLPetDog *)dog succ:(APDataServiceSuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSString *jsonstring = [dog mj_JSONString];
    NSDictionary *dict = @{@"data": jsonstring};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_dog_DogOwnerDogSaveByJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            succ();
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

@end
