//
//  NineSpaceView.m
//  AnimalProtect
//
//  Created by apple on 2018/5/12.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "NineSpaceImagesView.h"

// 宽度(自定义)
#define PIC_WIDTH 80
// 高度(自定义)
#define PIC_HEIGHT 80
// 列数(自定义)
#define COL_COUNT 3

@implementation NineSpaceImagesView

- (void)setPictures:(NSArray<UIImage *> *)pictures
{
    _pictures = pictures;
    
    [self reAddPictures];
}

- (void)reAddPictures
{
    [self removeAllSubviews];
    
    [self addPictures];
}

- (void)removeAllSubviews
{
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
}

/** 九宫格形式添加图片 */
- (void)addPictures {
    
    // 在for循环中添加
    // self.pictures.count中的self.pictures是一个图片数组，代表着要添加多少个图片
    for (int i = 0; i < self.pictures.count; i++) {
        //创建图片
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = self.pictures[i];
        
        imageView.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *ges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidLongPress:)];
        ges.minimumPressDuration = 1;
        [imageView addGestureRecognizer:ges];
        
        // 图片所在行
        NSInteger row = i / COL_COUNT;
        // 图片所在列
        NSInteger col = i % COL_COUNT;
        // 间距
        CGFloat margin = (self.bounds.size.width - (PIC_WIDTH * COL_COUNT)) / (COL_COUNT + 1);
        // PointX
        CGFloat picX = margin + (PIC_WIDTH + margin) * col;
        // PointY
        
        CGFloat marginY = 5;
        CGFloat picY = marginY + (PIC_HEIGHT + marginY) * row;
        
        // 图片的frame
        imageView.frame = CGRectMake(picX, picY, PIC_WIDTH, PIC_HEIGHT);
        
        [self addSubview:imageView];
    }
}

#pragma mark - IBAction

- (void)imageDidLongPress:(UIGestureRecognizer *)ges
{
    if (ges.state == UIGestureRecognizerStateBegan) {
        UIImageView *imageView = (UIImageView *)ges.view;
        UIImage *img = imageView.image;
        if ([self.pictures containsObject:img]) {
            NSMutableArray *arr = [self.pictures mutableCopy];
            [arr removeObject:img];
            
            self.pictures = arr;
        }
        [self reAddPictures];
    }
}

@end
