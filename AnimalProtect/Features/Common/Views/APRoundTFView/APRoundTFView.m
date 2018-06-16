//
//  APRoundTFView.m
//  AnimalProtect
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APRoundTFView.h"
#import "APRoundTF.h"

@interface APRoundTFView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet APRoundTF *roundTF;

@end

@implementation APRoundTFView

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
    
    [self.roundTF addTarget:self action:@selector(tfDidEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.roundTF.text = _text;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.roundTF.placeholder = _placeholder;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    self.roundTF.secureTextEntry = _secureTextEntry;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.roundTF setRoundColor:APRoundTFRoundColorYellow];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.roundTF setRoundColor:APRoundTFRoundColorGray];

}

#pragma mark - IBAction

- (void)tfDidEditingChanged:(UITextField *)textFeild
{
    self.text = textFeild.text;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(apRoundTFView:editingChanged:)]) {
        [self.delegate apRoundTFView:self editingChanged:textFeild];
    }
}

@end
