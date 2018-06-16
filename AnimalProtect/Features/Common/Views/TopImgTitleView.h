//
//  TopImgTitleView.h
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopImgTitleView;
@protocol TopImgTitleViewDelegate<NSObject>
@optional
- (void)topImgTitleViewDidTap:(TopImgTitleView *)topImgTitleView;
@end

/**
 上图下标题视图
 
 @author apem
 */
@interface TopImgTitleView : UIView

@property (nonatomic, strong) IBInspectable UIImage *image;
@property (nonatomic, strong) IBInspectable NSString *title;

@property (nonatomic, weak) IBOutlet id<TopImgTitleViewDelegate> delegate;

@end
