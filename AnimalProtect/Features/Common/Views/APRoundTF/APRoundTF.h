//
//  APRoundTF.h
//  AnimalProtect
//
//  Created by apple on 2018/5/7.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    APRoundTFRoundColorGray = 0x00,
    APRoundTFRoundColorYellow = 0x01,
}APRoundTFRoundColor;

@interface APRoundTF : UITextField

@property (nonatomic, assign) APRoundTFRoundColor roundColor;

@end
