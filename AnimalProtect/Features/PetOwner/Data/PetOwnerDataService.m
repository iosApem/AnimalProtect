//
//  PetOwnerDataService.m
//  AnimalProtect
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "PetOwnerDataService.h"
#import "CLPetDog.h"

@implementation PetOwnerDataService


- (void)requestNewsList:(APDataServiceArraySuccBlock)succ fail:(APDataServiceFailBlock)fail
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++) {
        CLNews *news = [[CLNews alloc] init];
        news.newsID = [NSString stringWithFormat:@"00%ld", i];
        news.title = @"有一种焦虑贩卖叫\"同龄人\"正在";
        news.createDate = [NSString stringWithFormat:@"2014-07-07 17:17"];
        
        [array addObject:news];
    }
    
    succ(array);
}

- (void)requestWithNewsID:(NSString *)newsID succ:(void(^)(CLNews *news))succ fail:(APDataServiceFailBlock)fail
{
    CLNews *news = [[CLNews alloc] init];
    news.newsID = [NSString stringWithFormat:@"00%d", 2];
    news.title = @"有一种焦虑贩卖叫\"同龄人\"正在";
    news.createDate = [NSString stringWithFormat:@"2018-08-08 17:17"];
    news.content = @"焦虑是对亲人或自己生命安全、前途命运等的过度担心而产生的一种烦躁情绪。其中含有着急、挂念、忧愁、紧张、恐慌、不安等成分。它与危急情况和难以预测、难以应付的事件有关。...\n分类 病理性焦虑";
    succ(news);
}

@end
