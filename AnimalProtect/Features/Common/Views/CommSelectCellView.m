//
//  CommSelectCellView.m
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import "CommSelectCellView.h"
#import "APNormalLabel.h"
#import "CommSelectVC.h"
#import "NSString+APUtils.h"

@interface CommSelectCellView()<CommSelectVCDelegate>

@property (weak, nonatomic) IBOutlet APNormalLabel *titleLabel;
@property (weak, nonatomic) IBOutlet APNormalLabel *selectLabel;

@end

@implementation CommSelectCellView

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
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewDidClick:)];
    [self.selectLabel addGestureRecognizer:ges];
    
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setSelectObject:(CommTFSelectObject *)selectObject
{
    _selectObject = selectObject;
    if([NSString notBlank:selectObject.NAME] == YES) {
        self.selectLabel.text = selectObject.NAME;
    } else {
        self.selectLabel.text = @"请选择";
    }
    
}

- (void)setSelectObjectArray:(NSArray<CommTFSelectObject *> *)selectObjectArray
{
    _selectObjectArray = selectObjectArray;
    
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    self.selectLabel.userInteractionEnabled = _enable;
}

#pragma mark - CommSelectVCDelegate

- (void)commSelectVC:(CommSelectVC *)commSelectVC dataDidSelect:(CommTFSelectObject *)data
{
    self.selectObject = data;
    
    [commSelectVC.navigationController popViewControllerAnimated:YES];
    
    NSInteger row = [self.selectObjectArray indexOfObject:data];
    if (self.delegate && [self.delegate respondsToSelector:@selector(commSelectCellView:didSelectAtIndex:)]) {
        [self.delegate commSelectCellView:self didSelectAtIndex:row];
    }
}
#pragma mark - IBAction

- (void)selfViewDidClick:(UIGestureRecognizer *)gesture
{
    CommSelectVC *vc = [[CommSelectVC alloc] init];
    vc.selectData = self.selectObject;
    vc.dataArray = self.selectObjectArray;
    vc.delegate = self;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UINavigationController *nav = (UINavigationController *)window.rootViewController;
    if ([nav isKindOfClass:[UINavigationController class]] == YES) {
        [nav pushViewController:vc animated:YES];
    }
}

@end
