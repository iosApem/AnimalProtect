//
//  PetOwnerDataService.m
//  AnimalProtect
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "PetOwnerDataService.h"
#import "CLNews.h"

@implementation PetOwnerDataService

- (void)requestNewsList:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_article_ArticleManageJson_action param:nil progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLNews mj_objectArrayWithKeyValuesArray:responseObject];
            succ(arr);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

- (void)requestWithNewsID:(NSNumber *)newsID succ:(void(^)(CLNews *news))succ fail:(APDataServiceFailBlock)fail;
{
    NSDictionary *dict = @{@"id": newsID ?: @""};
    [[APHTTPSession sharedSession] httpGETWithKey:api_key_article_ArticleManageJson_action param:dict progress:nil succ:^(id responseObject) {
        
        if (succ) {
            NSArray *arr = [CLNews mj_objectArrayWithKeyValuesArray:responseObject];
            CLNews *news = [arr firstObject];
            succ(news);
        }
        
    } fail:^(NSError *error) {
        if(fail) fail(error);
    }];
}

@end
