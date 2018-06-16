//
//  MainNavVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "MainNavVC.h"
#import "HbbUIStyleCenter.h"

@interface MainNavVC ()

@end

@implementation MainNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *navBgColor = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleNavColor];
    UIFont *font = [[HbbUIStyleCenter defaultCenter] sysFontWithKey:kHbbUIStyleFontSizeStyleL];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = navBgColor;
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    self.navigationBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
