//
//  NewsListVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "NewsListVC.h"
#import "CLNews.h"
#import "PetOwnerDataService.h"
#import "NewsCell.h"
#import "NewsDetailVC.h"

@interface NewsListVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<CLNews *> *newsArray;
@property (nonatomic, strong) PetOwnerDataService *petService;
@end

@implementation NewsListVC

- (void)initConfig
{
    [super initConfig];
    self.petService = [[PetOwnerDataService alloc] init];
}

- (void)initSubviews
{
    [super initSubviews];
    
    self.navigationItem.title = @"时事新闻";
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    NSString *className = NSStringFromClass([NewsCell class]);
    [self.tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    [self.tableView reloadData];
}

- (void)initData
{
    [super initData];
    [self requestNewsList];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = NSStringFromClass([NewsCell class]);
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
    
    CLNews *news = [self.newsArray objectAtIndex:indexPath.row];
    [cell setNews:news];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLNews *news = [self.newsArray objectAtIndex:indexPath.row];
    
    NewsDetailVC *vc = [[NewsDetailVC alloc] init];
    vc.newsID = news.id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark - 功能

/**
 请求宠物狗列表
 */
- (void)requestNewsList
{
    [self showHUBText:@"正在加载.."];
    [self.petService requestNewsList:^(NSArray *array) {
        [self hiddenHUB];
        self.newsArray = array;
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}

@end
