//
//  NewsDetailVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "NewsDetailVC.h"
#import "CLNews.h"
#import "PetOwnerDataService.h"

@interface NewsDetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) PetOwnerDataService *petService;

@end

@implementation NewsDetailVC

- (void)initConfig
{
    [super initConfig];
    self.petService = [[PetOwnerDataService alloc] init];
}

- (void)initSubviews
{
    [super initSubviews];
    
    self.navigationItem.title = @"新闻时事";
}

- (void)initData
{
    [super initData];
    [self setNibWithModel:nil];
    
    [self requestNews];
}

- (void)setNibWithModel:(CLNews *)news
{
    self.titleL.text = news.title;
    
    [self.webView loadHTMLString:news.content baseURL:nil];
}

- (void)requestNews
{
    [self showHUBText:@"正在加载.."];
    [self.petService requestWithNewsID:self.newsID succ:^(CLNews *news) {
        [self hiddenHUB];
        [self setNibWithModel:news];
        
    } fail:^(NSError *error) {
         [self hiddenHUB];
        [self toast:error.domain];
    }];
}

@end
