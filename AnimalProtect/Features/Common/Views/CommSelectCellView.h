//
//  CommSelectCellView.h
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommTFSelectObject.h"

@class CommSelectCellView;
@protocol CommSelectCellViewDelegate<NSObject>
@optional
- (void)commSelectCellView:(CommSelectCellView *)commSelectCellView didSelectAtIndex:(NSInteger)index;
@end

/**
 通用选择cell视图
 
 @author apem
 */
@interface CommSelectCellView : UIView

@property (nonatomic, strong) IBInspectable NSString *title;        //标题
@property (nonatomic, strong) CommTFSelectObject *selectObject;
@property (nonatomic, strong) NSArray<CommTFSelectObject *> *selectObjectArray;
@property (nonatomic, assign) IBInspectable BOOL enable;            //是否可用
@property (nonatomic, weak) IBOutlet id<CommSelectCellViewDelegate> delegate; //委托

@end
