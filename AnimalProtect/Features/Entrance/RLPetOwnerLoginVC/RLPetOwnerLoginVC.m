//
//  RLLoginVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "RLPetOwnerLoginVC.h"
#import "APRoundTFView.h"
#import "APRedBtn.h"
#import "APUsers.h"
#import "RLLoginService.h"
#import "MainNavVC.h"
#import "WBWorkBenchVC.h"
#import "AppDelegate.h"
#import "NewsListVC.h"
#import "TimerTool.h"

#import <UIKit/UIKit.h>

#define RLPetOwnerLoginVCSeond 60

@interface RLPetOwnerLoginVC ()<TimerToolDelegate>

@property (nonatomic, strong) RLLoginService *loginService;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet APRoundTFView *userTFView;
@property (weak, nonatomic) IBOutlet APRoundTFView *verifyCodeTFView;
@property (weak, nonatomic) IBOutlet APRedBtn *sendVerCodeBtn;
@property (weak, nonatomic) IBOutlet APRedBtn *loginBtn;
@property (weak, nonatomic) IBOutlet APRedBtn *casualBtn;

@property (nonatomic, strong) TimerTool *timerTool;

@property (nonatomic, strong) NSString *verifyCode; //验证码

@end

@implementation RLPetOwnerLoginVC

- (void)initConfig
{
    [super initConfig];
    
    self.loginService = [[RLLoginService alloc] init];
    self.timerTool = [[TimerTool alloc] initWithSecond:RLPetOwnerLoginVCSeond];
    self.timerTool.delegate = self;
}

#pragma mark - TimerToolDelegate

- (void)timerTool:(TimerTool *)timerTool currentSecond:(NSInteger)currentSecond complete:(BOOL)complete
{
    if (complete == NO) {
        
        NSInteger restSecond = RLPetOwnerLoginVCSeond - currentSecond;
        self.sendVerCodeBtn.titleLabel.text = [NSString stringWithFormat:@"%lds", restSecond];
        
    } else {
        self.sendVerCodeBtn.titleLabel.text = @"验证码";
        self.sendVerCodeBtn.enabled = YES;
        
    }
}

#pragma mark - IBAction

- (IBAction)apRedBtnDidClick:(APRedBtn *)apRedBtn
{
    //验证码
    if (apRedBtn == self.sendVerCodeBtn) {
        [self goToRequestVerCode];
    //登录按钮
    } else if (apRedBtn == self.loginBtn) {
        [self goToLogin];
    //随便逛逛
    } else if (apRedBtn == self.casualBtn) {
        [self goCasualLogin];
    }
}

#pragma mark - 功能

//收集登录信息
- (APUsers *)collectUsers
{
    APUsers *users = [[APUsers alloc] init];
    
    users.UserName = self.userTFView.text;
    users.verifyCode = self.verifyCodeTFView.text;
    
    return users;
}

//登录
- (void)goToLogin
{
    APUsers *user = [self collectUsers];
    user.userType = APUsersTypePetOwner;
    
    user.PWD = @"888888";

    //验证码对了
    if ([self.verifyCode isEqualToString:user.verifyCode] == YES) {
        
        [self.loginService loginWithUsers:user succ:^{
            
            [APUsers setCurrentUser:user];
            
            //跳转
            WBWorkBenchVC *workVC = [[WBWorkBenchVC alloc] init];
            MainNavVC *nav = [[MainNavVC alloc] initWithRootViewController:workVC];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            appDelegate.window.rootViewController = nav;
            
        } fail:^(NSError *error) {
            [self toast:error.domain];
        }];
    
    //验证码错了
    } else {
        [self toast:@"请输入正确的验证码"];
    }
    
    
    
}

//随便逛逛
- (void)goCasualLogin
{
    NewsListVC *vc = [[NewsListVC alloc] init];
    MainNavVC *nav = [[MainNavVC alloc] initWithRootViewController:vc];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = nav;
}

//请求验证码
- (void)goToRequestVerCode
{
    self.sendVerCodeBtn.enabled = NO;
    [self.timerTool start];
    [self.loginService requestVerCodeWithSucc:^(NSString *verifyCode){
        
        self.verifyCode = verifyCode;
        [self showDialogWithMsg:self.verifyCode];
        
    } fail:^(NSError *error) {
        [self toast:error.domain];
        self.sendVerCodeBtn.enabled = YES;
    }];
}

- (void)showDialogWithMsg:(NSString *)msg
{
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"您的验证码" message:msg delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alertV show];
}

@end
