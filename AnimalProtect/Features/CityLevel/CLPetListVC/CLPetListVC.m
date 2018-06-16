//
//  PetDogListVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLPetListVC.h"
#import "CLPetDog.h"
#import "CityLevelDataService.h"
#import "FourDescCell.h"
#import "CLPetDetailVC.h"

@interface CLPetListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic, strong) NSArray<CLPetDog *> *dogArray;
@property (nonatomic, strong) CityLevelDataService *dataService;

@end

@implementation CLPetListVC

- (void)initConfig
{
    [super initConfig];
    self.dataService = [[CityLevelDataService alloc] init];
}

- (void)initSubviews
{
    [super initSubviews];
    
    self.navigationItem.title = @"犬列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didClickRightBtn:)];
    
    NSString *className = NSStringFromClass([FourDescCell class]);
    [self.tb registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    [self.tb reloadData];
}

- (void)initData
{
    [super initData];
    [self requestDogList];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = NSStringFromClass([FourDescCell class]);
    FourDescCell *cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
    
    CLPetDog *dog = [self.dogArray objectAtIndex:indexPath.row];
    
    cell.firstTitleL.text = @"编号: ";
    cell.secondTitleL.text = @"犬种: ";
    cell.thirdTitleL.text = @"毛色: ";
    cell.fourthTitleL.text = @"犬龄: ";
    
    cell.firstTextL.text = dog.dogNo;
    cell.secondTextL.text = dog.name;
    cell.thirdTextL.text = dog.looks;
    cell.thirdTextL.text = dog.age;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLPetDog *dog = [self.dogArray objectAtIndex:indexPath.row];
    
    CLPetDetailVC *petDetailVC = [[CLPetDetailVC alloc] init];
    petDetailVC.dogID = dog.id;
    [self.navigationController pushViewController:petDetailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

#pragma mark - IBAction

/**
 右按钮被点击
 */
- (void)didClickRightBtn:(UIBarButtonItem *)item
{
    [self goToAddPet];
}

#pragma mark - skip page

/**
 去新增宠物
 */
- (void)goToAddPet
{
    CLPetDetailVC *vc = [[CLPetDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 请求

/**
 请求宠物狗列表
 */
- (void)requestDogList
{
    [self showHUBText:@"正在加载.."];
    [self.dataService requestPetListWithOwnerNo:self.ownerNo succ:^(NSArray *array) {
        [self hiddenHUB];
        self.dogArray = array;
        [self.tb reloadData];
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}

@end
