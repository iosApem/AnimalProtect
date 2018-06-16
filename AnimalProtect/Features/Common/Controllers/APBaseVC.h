//
//  APBaseVC.h
//  AnimalProtect
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSYLoadingHUD.h"

/**
 基础控制器
 
 @author apem
 */
@interface APBaseVC : UIViewController

- (void)initConfig;

- (void)initSubviews;

- (void)initData;

#pragma mark - toast and hub

- (void)toast:(NSString *)msg;

- (void)showHUBText:(NSString *)text;

- (void)hiddenHUB;

@end
