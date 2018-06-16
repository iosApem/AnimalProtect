//
//  CLPetListVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLPetOwnerCheckListVC.h"
#import "CityLevelDataService.h"
#import "FourDescCell.h"
#import "CLPetOwner.h"
#import "CLPetOwnerCheckDetailVC.h"

@interface CLPetOwnerCheckListVC ()

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic, strong) NSArray<CLPetOwner *> *array;
@property (nonatomic, strong) CityLevelDataService *dataService;

@end

@implementation CLPetOwnerCheckListVC

- (void)initConfig
{
    [super initConfig];
    self.dataService = [[CityLevelDataService alloc] init];
}

- (void)initSubviews
{
    [super initSubviews];
    
    self.navigationItem.title = @"犬主审核";
    
    NSString *className = NSStringFromClass([FourDescCell class]);
    [self.tb registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    [self.tb reloadData];
}

- (void)initData
{
    [super initData];
    [self requestCheckList];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = NSStringFromClass([FourDescCell class]);
    FourDescCell *cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
    
    CLPetOwner *record = [self.array objectAtIndex:indexPath.row];
    
    cell.firstTitleL.text = @"编号: ";
    cell.secondTitleL.text = @"姓名: ";
    cell.thirdTitleL.text = @"手机号: ";
    cell.fourthTitleL.text = @"机构: ";
    
    cell.firstTextL.text = record.ownerNo;
    cell.secondTextL.text = record.name;
    cell.thirdTextL.text = record.telephone;
    cell.thirdTextL.text = record.orgName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLPetOwner *obj = [self.array objectAtIndex:indexPath.row];
    
    CLPetOwnerCheckDetailVC *vc = [[CLPetOwnerCheckDetailVC alloc] init];
    vc.ownerID = obj.ownerNo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

#pragma mark - 功能

/**
 请求宠物狗列表
 */
- (void)requestCheckList
{
    [self showHUBText:@"正在加载.."];
    [self.dataService requestCheckListWithSucc:^(NSArray *array) {
        [self hiddenHUB];
        self.array = array;
        [self.tb reloadData];
        
        
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}

@end
