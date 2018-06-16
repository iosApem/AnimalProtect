//
//  APRoundTFView.h
//  AnimalProtect
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <UIKit/UIKit.h>
@class APRoundTFView;
@protocol APRoundTFViewDelegate<NSObject>
@optional
- (void)apRoundTFView:(APRoundTFView *)apRoundTFView editingChanged:(UITextField *)textField;
@end

@interface APRoundTFView : UIView

@property (nonatomic, strong) IBInspectable NSString *text;
@property (nonatomic, strong) IBInspectable NSString *placeholder;
@property (nonatomic, assign) IBInspectable BOOL secureTextEntry; //default is NO

@property (nonatomic, weak) id<APRoundTFViewDelegate> delegate;

@end
