//
//  CommTVCellView.h
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommTVCellView;
@protocol CommTVCellViewDelegate<NSObject>
@optional
- (void)commTVCellView:(CommTVCellView *)commTVCellView textFeildDidEditingChanged:(NSString *)text;
@end

/**
 通用的输入cell视图
 
 @athor apem
 */
@interface CommTVCellView : UIView

@property (nonatomic, strong) IBInspectable NSString *title;        //标题 default is "犬编号"
@property (nonatomic, strong) IBInspectable NSString *text;         //内容 default is "00300001001"
@property (nonatomic, assign) IBInspectable BOOL tfEnable;          //输入框是否可用 default is YES

@property (nonatomic, weak) IBOutlet id<CommTVCellViewDelegate> delegate; //委托

@end
