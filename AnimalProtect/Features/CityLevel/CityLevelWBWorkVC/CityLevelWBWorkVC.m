//
//  CityLevelWBWorkVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 apem. All rights reserved.
//


#import "CityLevelWBWorkVC.h"
#import "TopImgTitleView.h"
#import "CLPetOwnerCheckListVC.h"
#import "CLPetOwnerAdminVC.h"
#import "CLPetImmuneListVC.h"
#import "RLCityLevelLoginVC.h"
#import "AppDelegate.h"

@interface CityLevelWBWorkVC ()<TopImgTitleViewDelegate>

@property (weak, nonatomic) IBOutlet TopImgTitleView *petOwnerCheckV;
@property (weak, nonatomic) IBOutlet TopImgTitleView *petOwnerAdminV;
@property (weak, nonatomic) IBOutlet TopImgTitleView *petAdminV;

@end

@implementation CityLevelWBWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - TopImgTitleViewDelegate

- (void)topImgTitleViewDidTap:(TopImgTitleView *)topImgTitleView
{
    //畜主审核
    if (topImgTitleView == self.petOwnerCheckV) {
        CLPetOwnerCheckListVC *vc = [[CLPetOwnerCheckListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    ///畜主管理
    } else if (topImgTitleView == self.petOwnerAdminV) {
        CLPetOwnerAdminVC *vc = [[CLPetOwnerAdminVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    //畜兔管理
    } else if (topImgTitleView == self.petAdminV) {
        CLPetImmuneListVC *vc = [[CLPetImmuneListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

@end
