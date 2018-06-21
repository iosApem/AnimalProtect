//
//  PetDetailVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CLPetDetailVC.h"
#import "CommTVCellView.h"
#import "CommTFSelectView.h"
#import "APRedBtn.h"
#import "CityLevelDataService.h"
#import "CLPetDog.h"
#import "HXPhotoPicker.h"
#import "NineSpaceImagesView.h"
#import "CLBaseListDataService.h"

@interface CLPetDetailVC ()<CommTVCellViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nineViewConsHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CommTVCellView *dogIDCell;
@property (weak, nonatomic) IBOutlet CommTFSelectView *dogTypeCell;
@property (weak, nonatomic) IBOutlet CommTVCellView *dogColorCell;
@property (weak, nonatomic) IBOutlet CommTVCellView *dogAgeCell;
@property (weak, nonatomic) IBOutlet CommTVCellView *dogWeightCell;
@property (weak, nonatomic) IBOutlet CommTVCellView *remarkCell;

@property (weak, nonatomic) IBOutlet NineSpaceImagesView *nineSapceView;

@property (weak, nonatomic) IBOutlet APRedBtn *cameraBtn;
@property (weak, nonatomic) IBOutlet APRedBtn *saveBtn;
@property (weak, nonatomic) IBOutlet APRedBtn *returnBtn;

@property (nonatomic, strong) HXPhotoManager *manager;
@property (nonatomic, strong) NSArray<HXPhotoModel *> *photoList;

@property (nonatomic, strong) CityLevelDataService *dataService;
@property (nonatomic, strong) CLBaseListDataService *baseListService;
@property (nonatomic, strong) CLPetDog *dog;

@end

@implementation CLPetDetailVC

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
    [self initImagePicker];
    [self initNineImagesView];
}

- (void)initNav
{
    self.title = @"犬信息维护";
}

- (void)initImagePicker
{
    self.manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
}

- (void)initNineImagesView
{
    //todo
    self.nineViewConsHeight.constant = 0;
}

- (void)initData
{
    [super initData];
    
    self.dog = [[CLPetDog alloc] init];
    self.dog.ownerNo = self.ownerNo;
    
    [self setNibWithModel:nil];
    
    //编辑
    if(self.dogID != nil) {
        //请求宠物信息
        [self requestDogInfo:self.dogID];
    //新增
    } else {
        //do something
    }
    
    //请求宠物类型
    [self requestDogType];
}

- (void)setNibWithModel:(CLPetDog *)dog
{
    self.dogIDCell.text = dog.dogNo;
    self.dogTypeCell.selectObject = [CommTFSelectObject objWithCode:nil name:dog.name];
    self.dogColorCell.text = dog.looks;
    self.dogAgeCell.text = dog.age;
    self.dogWeightCell.text = dog.weight;
    self.remarkCell.text = dog.comments;
    
    //todo
    
}

- (void)setNibWithPhotoList:(NSArray<HXPhotoModel *> *)photoList
{
    NSMutableArray *images = [NSMutableArray array];
    HXPhotoModel *model;
    for (NSInteger i = 0;i < photoList.count;i ++) {
        model = [photoList objectAtIndex:i];
        if (model.thumbPhoto != nil) {
            [images addObject:model.thumbPhoto];
        }
    }
    
    if (images.count > 0) {
        self.nineSapceView.pictures = images;
        self.nineViewConsHeight.constant = 85;
    } else {
        self.nineViewConsHeight.constant = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (CLPetDog *)getDogFromNib
{
    CLPetDog *dog = self.dog;
    dog.dogNo = self.dogIDCell.text;
    dog.looks = self.dogColorCell.text;
    dog.name = self.dogTypeCell.selectObject.NAME;
    dog.age = self.dogAgeCell.text;
    dog.weight = self.dogWeightCell.text;
    dog.comments = self.remarkCell.text;
    
    return dog;
}

#pragma mark - IBAction

- (IBAction)cameraBtnDidClick:(id)sender {
    [self goToPickPicture];
}
- (IBAction)submitBtnDidClick:(id)sender {
    [self goToSubmit];
}
- (IBAction)returnBtnDidClick:(id)sender {
    [self goToReturn];
}

#pragma mark - function

- (void)goToPickPicture
{
    __weak typeof(self) ws = self;
    HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] init];
    vc.manager = self.manager;
    vc.doneBlock = ^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL original, HXAlbumListViewController *viewController) {
        
        ws.photoList = photoList;
        [ws setNibWithPhotoList:ws.photoList];
    };
    HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithRootViewController:vc];
//    nav.supportRotation = self.manager.configuration.supportRotation;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)goToSubmit
{
    CLPetDog *dog = [self getDogFromNib];
    
    [self requestSubmitDogInfo:dog];
}

- (void)goToReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - request
/**
 请求宠物信息
 */
- (void)requestDogInfo:(NSString *)dogID
{
    [self showHUBText:@"正在加载.."];
    [self.dataService requestPetInfoWithID:dogID succ:^(CLPetDog *dog) {
        [self hiddenHUB];
        self.dog = dog;
        [self setNibWithModel:self.dog];
        
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
        self.dogTypeCell.selectObjectArray = arr;
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)requestSubmitDogInfo:(CLPetDog *)dog
{
    [self showHUBText:@"正在提交.."];
    [self.dataService requestSubmitDogInfo:dog succ:^{
        [self hiddenHUB];
       
        if (self.delegate && [self.delegate respondsToSelector:@selector(clPetDetailVC:didSavePet:)]) {
            [self.delegate clPetDetailVC:self didSavePet:self.dog];
        }
        
    } fail:^(NSError *error) {
         [self hiddenHUB];
        [self toast:error.domain];
    }];
}

@end
