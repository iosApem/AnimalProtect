//
//  CommTVCellView.m
//  AnimalProtect
//
//  Created by chengenluo on 2018/5/8.
//  Copyright © 2018年 chengenluo. All rights reserved.
//

#import "CommTVCellView.h"
#import "APNormalLabel.h"
#import "HbbUIStyleCenter.h"

@interface CommTVCellView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet APNormalLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation CommTVCellView

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
    
    [self.textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.textField.delegate = self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = _title;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textField.text = _text;
}

- (void)setTfEnable:(BOOL)tfEnable
{
    _tfEnable = tfEnable;
    
    if (_tfEnable == YES) {
        self.textField.enabled = YES;
    } else {
        self.textField.enabled = NO;
    }
    
    [self setLineColorWithTextField:self.textField];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setLineColorWithTextField:textField];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setLineColorWithTextField:textField];
}

#pragma mark - IBAction

- (void)textFieldEditingChanged:(UITextField *)textFeild
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(commTVCellView:textFeildDidEditingChanged:)]) {
        [self.delegate commTVCellView:self textFeildDidEditingChanged:textFeild.text];
    }
}

- (void)setLineColorWithTextField:(UITextField *)textField
{
    UIColor *color;
    if (textField.enabled == YES) {
        
        if ([textField isFirstResponder] == YES) {
            
            color = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleLineHighlightColor];

        } else {
            
            color = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleLineEnableColor];

        }
        
    } else {
        color = [[HbbUIStyleCenter defaultCenter] colorWithKey:kHbbUIStyleColorStyleLineDisableColor];
    }
    self.lineView.backgroundColor = color;
}
@end
