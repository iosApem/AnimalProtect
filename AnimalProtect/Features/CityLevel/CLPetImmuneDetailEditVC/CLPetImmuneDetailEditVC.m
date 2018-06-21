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
@property (weak, nonatomic) IBOutlet CommTFSelectView *ownerNameCell; //宠物主
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
@property (nonatomic, strong) CLImmuneRecord *record;

@end

@implementation CLPetImmuneDetailEditVC

- (void)initConfig
{
    [super initConfig];
    
    self.dataService = [[CityLevelDataService alloc] init];
    self.baseListService = [[CLBaseListDataService alloc] init];
    
    //如果是新增的则创建免疫对象
    self.record = [[CLImmuneRecord alloc] init];
    NSDate *date = [NSDate date];
    self.record.immuneTime = [NSString datetimeStrWithDate:date];
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
    
    [self setNibWithModel:self.record];
    
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
    self.vaccineFactoryCell.selectObject = [CommTFSelectObject objWithCode:nil name:record.vaccineFactory];
    self.vaccineKindCell.selectObject = [CommTFSelectObject objWithCode:nil name:record.vaccineKind];
    
//    //编辑
//    if(self.immuneID != nil) {
    if ([NSString notBlank:record.immunityQty] == YES) {
        self.immunityQtyCell.tfEnable = NO;
    } else {
        self.immunityQtyCell.tfEnable = YES;
    }
    
    if ([NSString notBlank:record.vaccineQty] == YES) {
        self.vaccineQtyCell.tfEnable = NO;
    } else {
        self.vaccineQtyCell.tfEnable = YES;
    }
    
    if([NSString notBlank:record.dogName] == YES) {
        self.dogNameCell.enable = NO;
    } else {
        self.dogNameCell.enable = YES;
    }
    
    if([NSString notBlank:record.ownerNo] == YES) {
        self.ownerNameCell.enable = NO;
    } else {
        self.ownerNameCell.enable = YES;
    }
    
    if([NSString notBlank:record.vaccineFactory] == YES) {
        self.vaccineFactoryCell.enable = NO;
    } else {
        self.vaccineFactoryCell.enable = YES;
    }
    
    if([NSString notBlank:record.vaccineKind] == YES) {
        self.vaccineKindCell.enable = NO;
    } else {
        self.vaccineKindCell.enable = YES;
    }
    
//    //新增
//    } else {
//        //do something
//    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (CLImmuneRecord *)getModelFromNib
{
    CLImmuneRecord *record = self.record;
    
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
        
        self.record = record;
        [self setNibWithModel:self.record];
        
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
    [self.dataService requestPetOwnerListWithSucc:^(NSArray *array) {
        
        NSArray<CommTFSelectObject *> *objArray = [CLPetOwner dictArrayWithArray:array];
        self.ownerNameCell.selectObjectArray = objArray;
        
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
