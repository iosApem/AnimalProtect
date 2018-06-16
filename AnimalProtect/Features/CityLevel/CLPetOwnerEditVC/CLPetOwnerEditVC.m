//
//  PersonInfoVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLPetOwnerEditVC.h"
#import "CommTVCellView.h"
#import "CommTFSelectView.h"
#import "APRedBtn.h"
#import "CLPetOwner.h"
#import "CityLevelDataService.h"
#import "CLBaseListDataService.h"

@interface CLPetOwnerEditVC ()<CommTFSelectViewDelegate>

@property (weak, nonatomic) IBOutlet CommTVCellView *phoneV;
@property (weak, nonatomic) IBOutlet CommTVCellView *dogManID;
@property (weak, nonatomic) IBOutlet CommTVCellView *nameV;
@property (weak, nonatomic) IBOutlet CommTFSelectView *streetV;
@property (weak, nonatomic) IBOutlet CommTFSelectView *countrysideV;
@property (weak, nonatomic) IBOutlet CommTVCellView *addressV;
@property (weak, nonatomic) IBOutlet APRedBtn *saveBtn;

@property (nonatomic, strong) CityLevelDataService *dataService;
@property (nonatomic, strong) CLBaseListDataService *baseListService;

@property (nonatomic, strong) CLPetOwner *owner;   //宠物主

@end

@implementation CLPetOwnerEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataService = [[CityLevelDataService alloc] init];
    self.baseListService = [[CLBaseListDataService alloc] init];
    
    [self setNibWithModel:nil];
    
    //查看
    if(self.type == CLPetOwnerEditVCTypeSee) {
        [self requestPetOwner];
    //其他
    } else {
        //编辑
        if(self.petOwnerID != nil) {
            [self requestPetOwner];
        //新增
        } else {
            [self requestOrg];
        }
        
    }
    
}

- (void)initSubviews
{
    [super initSubviews];
    
    if (self.type == CLPetOwnerEditVCTypeEdit) {
        //编辑
        if(self.petOwnerID != nil) {
            self.title = @"编辑畜主";
        //新增
        } else {
            self.title = @"新增畜主";
        }
        
        self.phoneV.tfEnable = YES;
        self.dogManID.tfEnable = NO;
        self.nameV.tfEnable = YES;
        self.streetV.mode = CommTFSelectViewModeSelect;
        self.streetV.enable = YES;
        self.countrysideV.mode = CommTFSelectViewModeSelect;
        self.countrysideV.enable = YES;
        self.addressV.tfEnable = YES;
        self.saveBtn.hidden = NO;
        
    } else {
        self.title = @"个人信息";
        
        self.phoneV.tfEnable = NO;
        self.dogManID.tfEnable = NO;
        self.nameV.tfEnable = NO;
        self.streetV.mode = CommTFSelectViewModeInput;
        self.streetV.enable = NO;
        self.countrysideV.mode = CommTFSelectViewModeInput;
        self.countrysideV.enable = NO;
        self.addressV.tfEnable = NO;
        self.saveBtn.hidden = YES;
    }
}

- (void)setNibWithModel:(CLPetOwner *)person
{
    self.phoneV.text = person.telephone;
    self.dogManID.text = person.ownerNo;
    self.nameV.text = person.name;
    self.streetV.selectObject = [CommTFSelectObject objWithCode:person.orgCode name:person.orgName];
    self.countrysideV.selectObject = [CommTFSelectObject objWithCode:person.village name:person.villageName];
    self.addressV.text = person.address;
}

- (CLPetOwner *)getPersonFromNib
{
    CLPetOwner *person = [[CLPetOwner alloc] init];
    person.telephone = self.phoneV.text;
    person.ownerNo = self.dogManID.text;
    person.name = self.nameV.text;
    person.orgCode = self.streetV.selectObject.CODE;
    person.orgName = self.streetV.selectObject.NAME;
    person.village = self.countrysideV.selectObject.CODE;
    person.villageName = self.countrysideV.selectObject.NAME;
    person.address = self.addressV.text;
    return person;
}

#pragma mark  - CommTFSelectViewDelegate

- (void)commTFSelectView:(CommTFSelectView *)commTFSelectView didSelectItem:(CommTFSelectObject *)obj;
{
    [self requestVillageWithOrgCode:obj.CODE];
}

#pragma mark - IBAction

- (IBAction)saveBtnDidClick:(APRedBtn *)sender
{
    [self submitSheet];
}

#pragma mark - function

//请求宠物主信息
- (void)requestPetOwner
{
    [self showHUBText:@"正在加载.."];
    [self.dataService requestPetOwnerWithID:self.petOwnerID succ:^(CLPetOwner *person) {
        [self hiddenHUB];
        [self setNibWithModel:person];
        
        [self requestOrg];
        [self requestVillageWithOrgCode:person.orgCode];
        
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}

//请求机构
- (void)requestOrg
{
    [self.baseListService getCLOrgWithParentCode:nil succ:^(NSArray *array) {
        
        NSArray *selectArr = [CLOrg selectObjectArrWithArr:array];
        self.streetV.selectObjectArray = selectArr;
        
    } fail:^(NSError *error) {
        [self toast:error.domain];
    }];
}

//请求村别
- (void)requestVillageWithOrgCode:(NSString *)orgCode
{
    [self.baseListService getCLOrgWithParentCode:orgCode succ:^(NSArray *array) {
        
        NSArray *selectArr = [CLOrg selectObjectArrWithArr:array];
        self.countrysideV.selectObjectArray = selectArr;
        
    } fail:^(NSError *error) {
        [self toast:error.domain];
    }];
}

- (void)submitSheet
{
    CLPetOwner *person = [self getPersonFromNib];
    [self showHUBText:@"正在提交.."];
    [self.dataService requestSubmitPetOwner:person succ:^{
        [self hiddenHUB];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(clPetOwnerEditVC:didSaveOwner:)]) {
            [self.delegate clPetOwnerEditVC:self didSaveOwner:person];
        }
    } fail:^(NSError *error) {
        [self hiddenHUB];
        [self toast:error.domain];
    }];
}

@end
