//
//  CLPetImmuneDetailVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLPetImmuneDetailEditVC.h"
#import "CommTVCellView.h"
#import "CommTFSelectView.h"
#import "APRedBtn.h"
#import "CityLevelDataService.h"
#import "CLImmuneRecord.h"
#import "CLBaseListDataService.h"

@interface CLPetImmuneDetailEditVC ()<CommTFSelectViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveBtnConsHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *saveBtnConsTop;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CommTVCellView *immuneNoCell; //流水号
@property (weak, nonatomic) IBOutlet CommTFSelectView *ownerNameCell;
@property (weak, nonatomic) IBOutlet CommTFSelectView *dogNameCell;
@property (weak, nonatomic) IBOutlet CommTVCellView *immuneTimeCell;
@property (weak, nonatomic) IBOutlet CommTVCellView *immunityQtyCell;
@property (weak, nonatomic) IBOutlet CommTVCellView *vaccineQtyCell;
@property (weak, nonatomic) IBOutlet CommTVCellView *vaccineBatchCell;
@property (weak, nonatomic) IBOutlet CommTFSelectView *vaccineFactoryCell;
@property (weak, nonatomic) IBOutlet CommTFSelectView *vaccineKindCell;

@property (weak, nonatomic) IBOutlet APRedBtn *saveBtn;
@property (weak, nonatomic) IBOutlet APRedBtn *returnBtn;

@property (nonatomic, strong) CityLevelDataService *dataService;
@property (nonatomic, strong) CLBaseListDataService *baseListService;

@end

@implementation CLPetImmuneDetailEditVC

- (void)initConfig
{
    [super initConfig];
    
    self.dataService = [[CityLevelDataService alloc] init];
    self.baseListService = [[CLBaseListDataService alloc] init];
}

- (void)initSubviews
{
    [super initSubviews];
    [self initNav];
}

- (void)initNav
{
    self.title = @"犬信息编辑";
}

- (void)initData
{
    [super initData];
    
    [self setNibWithModel:nil];
    
    //编辑
    if(self.immuneID != nil) {
        //请求宠物信息
        [self requestImmuneWithID:self.immuneID];
    //新增
    } else {
        //do something
    }
    
    //请求宠物类型
    [self requestDogType];
    
    [self requestDogOwner];
    
    [self requestVaccineFactory];
    
    [self requestVaccineKind];
}

- (void)setNibWithModel:(CLImmuneRecord *)record
{
    self.immuneNoCell.text = record.immuneNo;
    self.ownerNameCell.selectObject = [CommTFSelectObject objWithCode:record.ownerNo name:record.ownerName];
    self.dogNameCell.selectObject = [CommTFSelectObject objWithCode:nil name:record.dogName];
    self.immuneTimeCell.text = record.immuneTime;
    self.immunityQtyCell.text = record.immunityQty;
    self.vaccineQtyCell.text = record.vaccineQty;
    self.vaccineBatchCell.text = record.vaccineBatch;
    self.dogNameCell.selectObject = [CommTFSelectObject objWithCode:nil name:record.vaccineFactory];
    self.dogNameCell.selectObject = [CommTFSelectObject objWithCode:nil name:record.vaccineKind];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (CLImmuneRecord *)getModelFromNib
{
    CLImmuneRecord *record = [[CLImmuneRecord alloc] init];
    record.immuneNo = self.immuneNoCell.text;
    record.ownerNo = self.ownerNameCell.selectObject.CODE;
    record.ownerName = self.ownerNameCell.selectObject.NAME;
    record.dogName = self.dogNameCell.selectObject.NAME;
    record.immuneTime = self.immuneTimeCell.text;
    record.immunityQty = self.immunityQtyCell.text;
    record.vaccineQty = self.vaccineQtyCell.text;
    record.vaccineBatch = self.vaccineBatchCell.text;
    record.vaccineFactory = self.vaccineFactoryCell.selectObject.NAME;
    record.vaccineKind = self.vaccineKindCell.selectObject.NAME;
    
    return record;
}

#pragma mark - IBAction

- (IBAction)submitBtnDidClick:(id)sender {
    [self goToSubmit];
}
- (IBAction)returnBtnDidClick:(id)sender {
    [self goToReturn];
}

#pragma mark - function

- (void)goToSubmit
{
    CLImmuneRecord *model = [self getModelFromNib];
    [self requestSubmitImmune:model];
}

- (void)goToReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - request
/**
 请求宠物信息
 */
- (void)requestImmuneWithID:(NSString *)immuneID
{
    [self showHUBText:@"正在加载.."];
    [self.dataService requestImmuneWithId:immuneID succ:^(CLImmuneRecord *record) {
        [self hiddenHUB];
        [self setNibWithModel:record];
        
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}

/**
 请求宠物类型
 */
- (void)requestDogType
{
    [self.baseListService getCLSysDictWithType:CLSysDictTypePetKind succ:^(NSArray *array) {
        
        NSArray *arr = [CLSysDict selectObjectArrWithArr:array];
        self.dogNameCell.selectObjectArray = arr;
        
    } fail:^(NSError *error) {
        [self toast:error.domain];
    }];
}

/**
 请求宠物主
 */
- (void)requestDogOwner
{
    [self.baseListService getCLSysDictWithType:CLSysDictTypePetKind succ:^(NSArray *array) {
        
        NSArray *arr = [CLSysDict selectObjectArrWithArr:array];
        self.dogNameCell.selectObjectArray = arr;
        
    } fail:^(NSError *error) {
        [self toast:error.domain];
    }];
}

/**
 请求疫苗厂家
 */
- (void)requestVaccineFactory
{
    [self.baseListService getCLSysDictWithType:CLSysDictTypeVaccineFactory succ:^(NSArray *array) {
        
        NSArray *arr = [CLSysDict selectObjectArrWithArr:array];
        self.vaccineFactoryCell.selectObjectArray = arr;
        
    } fail:^(NSError *error) {
        [self toast:error.domain];
    }];
}

/**
 请求疫苗种类
 */
- (void)requestVaccineKind
{
    [self.baseListService getCLSysDictWithType:CLSysDictTypeVaccineKind succ:^(NSArray *array) {
        
        NSArray *arr = [CLSysDict selectObjectArrWithArr:array];
        self.vaccineKindCell.selectObjectArray = arr;
        
    } fail:^(NSError *error) {
        [self toast:error.domain];
    }];
}

- (void)requestSubmitImmune:(CLImmuneRecord *)record
{
    [self showHUBText:@"正在提交.."];
    [self.dataService requestSubmitImmune:record succ:^{
        [self hiddenHUB];
        [self goToReturn];
        
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}

@end
