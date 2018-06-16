//
//  WBWorkBenchVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "WBWorkBenchVC.h"
#import "CityLevelWBWorkVC.h"
#import "PetOwnerWBWorkVC.h"
#import "APUsers.h"
#import "RLCityLevelLoginVC.h"
#import "AppDelegate.h"

typedef enum {
    WBWorkBenchTypeNone = 0x00,
    WBWorkBenchTypePetOwner = 0x01,
    WBWorkBenchTypeCityLevel = 0x02,
}WBWorkBenchType;

@interface WBWorkBenchVC ()

@property (nonatomic, weak) CityLevelWBWorkVC *cityLevelWbVC;
@property (nonatomic, weak) PetOwnerWBWorkVC *petOwnerWbVC;


@end

@implementation WBWorkBenchVC

- (void)initSubviews
{
    [super initSubviews];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_tuichu.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 22, 22);
    [button addTarget:self action:@selector(rightBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    CityLevelWBWorkVC *cityLevelWBVC = [[CityLevelWBWorkVC alloc] init];
    [self.view addSubview:cityLevelWBVC.view];
    [self addChildViewController:cityLevelWBVC];
    self.cityLevelWbVC = cityLevelWBVC;
    
    PetOwnerWBWorkVC *petOwnerWBVC = [[PetOwnerWBWorkVC alloc] init];
    [self.view addSubview:petOwnerWBVC.view];
    [self addChildViewController:petOwnerWBVC];
    self.petOwnerWbVC = petOwnerWBVC;
    
    [self setCurrentWBWithType:WBWorkBenchTypeNone];
    
}

- (void)initData
{
    [super initData];
    
    [self getCurrentUserAndInitUI];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.petOwnerWbVC.view.frame = self.view.bounds;
    self.cityLevelWbVC.view.frame = self.view.bounds;

}

#pragma mark - IBAction

- (void)rightBtnDidClick:(UIBarButtonItem *)item
{
    RLCityLevelLoginVC *loginVC = [[RLCityLevelLoginVC alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = loginVC;
}

- (void)getCurrentUserAndInitUI
{
    APUsers *users = [APUsers currentUser];
    if(users.userType == APUsersTypePetOwner) {
        [self setCurrentWBWithType:WBWorkBenchTypePetOwner];
    } else if(users.userType == APUsersTypeCityLevel){
        [self setCurrentWBWithType:WBWorkBenchTypeCityLevel];
    } else {
        [self setCurrentWBWithType:WBWorkBenchTypeNone];
    }
}

- (void)setCurrentWBWithType:(WBWorkBenchType)type
{
    if (type == WBWorkBenchTypeNone) {
        
        self.cityLevelWbVC.view.hidden = YES;
        self.petOwnerWbVC.view.hidden = YES;
        self.title = @"";
        
    } else if(type == WBWorkBenchTypePetOwner){
        
        self.cityLevelWbVC.view.hidden = YES;
        self.petOwnerWbVC.view.hidden = NO;
        self.title = @"宠物主角色";
        
    } else if(type == WBWorkBenchTypeCityLevel){
        
        self.cityLevelWbVC.view.hidden = NO;
        self.petOwnerWbVC.view.hidden = YES;
        self.title = @"街镇角色";
        
    }
}

@end
