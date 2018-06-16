//
//  CommTFSelectView.h
//  AnimalProtect
//
//  Created by apple on 2018/5/12.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommTFSelectObject.h"

/**
 操作模型
 */
typedef enum {
    CommTFSelectViewModeInput = 0x00, //输入
    CommTFSelectViewModeSelect = 0x01,//选择
}CommTFSelectViewMode;

@class CommTFSelectView;
@protocol CommTFSelectViewDelegate<NSObject>
@optional
//文本发生改变
- (void)commTFSelectView:(CommTFSelectView *)commTFSelectView textDidChanged:(NSString *)text;

//选择一个item
- (void)commTFSelectView:(CommTFSelectView *)commTFSelectView didSelectItem:(CommTFSelectObject *)obj;


@end

/**
 通用的选择或输入视图
 
 @author apem
 */
@interface CommTFSelectView : UIView

@property (nonatomic, strong) IBInspectable NSString *title;        //标题 default is "犬编号"
@property (nonatomic, strong) NSString *text; //输入内容
@property (nonatomic, strong) CommTFSelectObject *selectObject;         
@property (nonatomic, strong) NSArray<CommTFSelectObject *> *selectObjectArray;

@property (nonatomic, assign) IBInspectable NSInteger mode;         //操作模型
@property (nonatomic, assign) IBInspectable BOOL enable;            //是否可用
@property (nonatomic, weak) IBOutlet id<CommTFSelectViewDelegate> delegate; //委托


@end
