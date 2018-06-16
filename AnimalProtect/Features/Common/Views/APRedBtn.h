//
//  APRedBtn.h
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 颜色类型
 */
typedef enum {
    APRedBtnColorStyleRed = 0x00,
    APRedBtnColorStyleBlue = 0x01,
}APRedBtnColorStyle;

/**
 红色按钮
 
 @author apem
 */
@interface APRedBtn : UIButton

@property (nonatomic, assign) IBInspectable NSInteger colorStyle;  //颜色类型 default is 0

@end
