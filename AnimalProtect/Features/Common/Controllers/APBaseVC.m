//
//  APBaseVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APBaseVC.h"
#import "Toast+UIView.h"

@interface APBaseVC ()

@property (nonatomic, strong) LSYLoadingHUD *hud;

@end

@implementation APBaseVC

- (instancetype)init
{
    if (self = [super init]) {
        [self initConfig];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubviews];
    
    [self initData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"##%@ %@", NSStringFromClass([self class]), @"viewDidAppear:");
}

- (void)initConfig
{
    
}

- (void)initSubviews
{
    self.hud = [[LSYLoadingHUD alloc] init];
}

- (void)initData
{
    
}

- (void)toast:(NSString *)msg
{
    [self.view makeToast:msg duration:1.5 position:@"center_bottom"];
}

- (void)showHUBText:(NSString *)text
{
    [self.hud showHUDText:text inViewController:self];
}

- (void)hiddenHUB
{
    [self.hud hiddenHUDViewController:self];
}

@end
