//
//  RLLoginVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "RLCityLevelLoginVC.h"
#import "APRoundTFView.h"
#import "APRedBtn.h"
#import "APUsers.h"
#import "RLLoginService.h"
#import "MainNavVC.h"
#import "WBWorkBenchVC.h"
#import "AppDelegate.h"
#import "RLPetOwnerLoginVC.h"

@interface RLCityLevelLoginVC ()

@property (nonatomic, strong) RLLoginService *loginService;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet APRoundTFView *userTFView;
@property (weak, nonatomic) IBOutlet APRoundTFView *pwdTFView;
@property (weak, nonatomic) IBOutlet APRedBtn *loginBtn;
@property (weak, nonatomic) IBOutlet APRedBtn *petLoginBtn;

@end

@implementation RLCityLevelLoginVC

- (void)initConfig
{
    [super initConfig];
    
    self.loginService = [[RLLoginService alloc] init];

}

- (void)initSubviews
{
    [super initSubviews];
}

#pragma mark - IBAction

- (IBAction)apRedBtnDidClick:(APRedBtn *)apRedBtn
{
    //登录按钮
    if (apRedBtn == self.loginBtn) {
        [self goToLogin];
    //宠物主登录按钮
    } else if (apRedBtn == self.petLoginBtn) {
        [self goToPetOwnerLogin];
    }
}

#pragma mark - 功能

//收集登录信息
- (APUsers *)collectUsers
{
    APUsers *users = [[APUsers alloc] init];
    
    users.UserName = self.userTFView.text;
    users.PWD = self.pwdTFView.text;
    
    return users;
}

//登录
- (void)goToLogin
{
    APUsers *user = [self collectUsers];
    user.userType = APUsersTypeCityLevel;
    
    //缩回键盘
    [self.view endEditing:YES];
    
    [self showHUBText:@"正在登录.."];
    [self.loginService loginWithUsers:user succ:^{
        [self hiddenHUB];
                
        //跳转
        WBWorkBenchVC *workVC = [[WBWorkBenchVC alloc] init];
        MainNavVC *nav = [[MainNavVC alloc] initWithRootViewController:workVC];
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.window.rootViewController = nav;
        
        
    } fail:^(NSError *error) {
        [self toast:error.domain];
        [self hiddenHUB];
    }];
    
}

//宠物主登录
- (void)goToPetOwnerLogin
{
    RLPetOwnerLoginVC *vc = [[RLPetOwnerLoginVC alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = vc;
}

@end

