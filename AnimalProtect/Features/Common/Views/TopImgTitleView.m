//
//  TopImgTitleView.m
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import "TopImgTitleView.h"
#import "APNormalLabel.h"
#import "HbbUIStyleCenter.h"

@interface TopImgTitleView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet APNormalLabel *titleLabel;

@end

@implementation TopImgTitleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        [self initFromNib];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initFromNib];
    }
    return self;
}

- (void)initFromNib
{
    Class cls = [self class];
    NSString *clsStr = NSStringFromClass(cls);
    NSBundle *bundle = [NSBundle bundleForClass:cls];
    UINib *nib = [UINib nibWithNibName:clsStr bundle:bundle];
    UIView *containerView = [nib instantiateWithOwner:self options:nil][0];
    CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    containerView.frame = newFrame;
    [self addSubview:containerView];
    
    UIFont *font = [[HbbUIStyleCenter defaultCenter] sysFontWithKey:kHbbUIStyleFontSizeStyleS];
    self.titleLabel.font = font;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

#pragma mark - IBAction

- (IBAction)viewDidTap:(UITapGestureRecognizer *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topImgTitleViewDidTap:)]) {
        [self.delegate topImgTitleViewDidTap:self];
    }
}

@end
