//
//  CLPetOwnerAdminVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLPetOwnerAdminVC.h"
#import "CityLevelDataService.h"
#import "CLPetOwner.h"
#import "FourDescCell.h"
#import "CLPetOwnerEditVC.h"
#import "CLPetListVC.h"

@interface CLPetOwnerAdminVC ()<UITableViewDelegate, UITableViewDataSource, CLPetOwnerEditVCDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic, strong) NSArray<CLPetOwner *> *dataArray;
@property (nonatomic, strong) CityLevelDataService *dataService;

@end

@implementation CLPetOwnerAdminVC

- (void)initConfig
{
    [super initConfig];
    self.dataService = [[CityLevelDataService alloc] init];
}

- (void)initSubviews
{
    [super initSubviews];
    
    self.navigationItem.title = @"畜主管理";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didClickRightBtn:)];
    
    NSString *className = NSStringFromClass([FourDescCell class]);
    [self.tb registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    [self.tb reloadData];
}

- (void)initData
{
    [super initData];
    [self requestPetOwnerList];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = NSStringFromClass([FourDescCell class]);
    FourDescCell *cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
    
    CLPetOwner *record = [self.dataArray objectAtIndex:indexPath.row];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLPetOwner *record = [self.dataArray objectAtIndex:indexPath.row];
    //去宠物主的宠物列表
    [self goToPetListWithOwnerNo:record.ownerNo];
}

#pragma mark - CLPetOwnerEditVCDelegate

- (void)clPetOwnerEditVC:(CLPetOwnerEditVC *)clPetOwnerEditVC didSaveOwner:(CLPetOwner *)owner
{
    //请求宠物主列表
    [self requestPetOwnerList];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - IBAction

/**
 右按钮被点击
 */
- (void)didClickRightBtn:(UIBarButtonItem *)item
{
    [self goToAddPetOwner];
}

#pragma mark - 功能

/**
 新增宠物主
 */
- (void)goToAddPetOwner
{
    CLPetOwnerEditVC *vc = [[CLPetOwnerEditVC alloc] init];
    vc.type = CLPetOwnerEditVCTypeEdit;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 去宠物主的宠物列表

 @param ownerNo 宠物主No
 */
- (void)goToPetListWithOwnerNo:(NSString *)ownerNo
{
    CLPetListVC *vc = [[CLPetListVC alloc] init];
    vc.ownerNo = ownerNo;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 请求宠物主列表
 */
- (void)requestPetOwnerList
{
    [self showHUBText:@"正在加载.."];
    [self.dataService requestPetOwnerListWithSucc:^(NSArray *array) {
        [self hiddenHUB];
        self.dataArray = array;
        [self.tb reloadData];
        
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}

@end
