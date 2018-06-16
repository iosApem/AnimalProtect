//
//  CLPetListVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLPetImmuneListVC.h"
#import "CLImmuneRecord.h"
#import "CityLevelDataService.h"
#import "FourDescCell.h"
#import "CLPetImmuneDetailEditVC.h"

@interface CLPetImmuneListVC ()

@property (weak, nonatomic) IBOutlet UITableView *tb;

@property (nonatomic, strong) NSArray<CLImmuneRecord *> *array;
@property (nonatomic, strong) CityLevelDataService *dataService;

@end

@implementation CLPetImmuneListVC

- (void)initConfig
{
    [super initConfig];
    self.dataService = [[CityLevelDataService alloc] init];
}

- (void)initSubviews
{
    [super initSubviews];
    
    self.navigationItem.title = @"犬兔列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didClickRightBtn:)];
    
    NSString *className = NSStringFromClass([FourDescCell class]);
    [self.tb registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
    [self.tb reloadData];
}

- (void)initData
{
    [super initData];
    [self requestImmuneList];
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
    
    CLImmuneRecord *record = [self.array objectAtIndex:indexPath.row];
    
    cell.firstTitleL.text = @"时间: ";
    cell.secondTitleL.text = @"犬编号: ";
    cell.thirdTitleL.text = @"用量: ";
    cell.fourthTitleL.text = @"犬主: ";
    
    cell.firstTextL.text = record.immuneTime;
    cell.secondTextL.text = record.dogNo;
    cell.thirdTextL.text = record.vaccineQty;
    cell.thirdTextL.text = record.ownerName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CLImmuneRecord *obj = [self.array objectAtIndex:indexPath.row];
    
    CLPetImmuneDetailEditVC *vc = [[CLPetImmuneDetailEditVC alloc] init];
    vc.immuneID = obj.immuneNo;
    [self.navigationController pushViewController:vc animated:YES];
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
    [self goToAddImmune];
}

#pragma mark - 功能

/**
 请求宠物狗列表
 */
- (void)requestImmuneList
{
    [self showHUBText:@"正在加载.."];
    [self.dataService requestImmuneListWithOwnerNo:self.ownerNo succ:^(NSArray *array) {
        [self hiddenHUB];
        self.array = array;
        [self.tb reloadData];
        
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}


/**
 新增免疫记录
 */
- (void)goToAddImmune
{
    
}

@end
