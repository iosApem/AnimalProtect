//
//  CommTFSelectView.m
//  AnimalProtect
//
//  Created by apple on 2018/5/12.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CommTFSelectView.h"
#import "CommTVCellView.h"
#import "CommSelectCellView.h"

@interface CommTFSelectView()<CommTVCellViewDelegate, CommSelectCellViewDelegate>

@property (nonatomic, strong) CommTVCellView *tvCell;
@property (nonatomic, strong) CommSelectCellView *selectCell;

@end

@implementation CommTFSelectView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
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
    [self initTVCell];
    [self initSelectCell];
    
    [self setMode:CommTFSelectViewModeInput];
    [self setEnable:YES];
}

- (void)initTVCell
{
    self.tvCell = [[CommTVCellView alloc] initWithFrame:CGRectZero];
    self.tvCell.delegate = self;
    [self addSubview:self.tvCell];
}

- (void)initSelectCell
{
    self.selectCell = [[CommSelectCellView alloc] initWithFrame:CGRectZero];
    self.selectCell.delegate = self;
    [self addSubview:self.selectCell];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tvCell.frame = self.bounds;
    self.selectCell.frame = self.bounds;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.tvCell.title = _title;
    self.selectCell.title = _title;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.tvCell.text = _text;
}

- (void)setSelectObject:(CommTFSelectObject *)selectObject
{
    _selectObject = selectObject;
    self.tvCell.text = _selectObject.NAME;
    self.selectCell.selectObject = selectObject;
}

- (void)setSelectObjectArray:(NSArray<CommTFSelectObject *> *)selectObjectArray
{
    _selectObjectArray = selectObjectArray;
    self.selectCell.selectObjectArray = _selectObjectArray;
}

- (void)setMode:(NSInteger)mode
{
    if (mode == CommTFSelectViewModeInput) {
        self.tvCell.hidden = NO;
        self.selectCell.hidden = YES;
    } else {
        self.tvCell.hidden = YES;
        self.selectCell.hidden = NO;
    }
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    
    self.tvCell.tfEnable = _enable;
    self.selectCell.enable = _enable;
}

#pragma mark - CommTVCellViewDelegate, CommSelectCellViewDelegate

- (void)commTVCellView:(CommTVCellView *)commTVCellView textFeildDidEditingChanged:(NSString *)text
{
    self.text = text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(commTFSelectView:textDidChanged:)]) {
        [self.delegate commTFSelectView:self textDidChanged:text];
    }
}

- (void)commSelectCellView:(CommSelectCellView *)commSelectCellView didSelectAtIndex:(NSInteger)index
{
    CommTFSelectObject *selectObj = [commSelectCellView.selectObjectArray objectAtIndex:index];
    
    self.selectObject = selectObj;
    if (self.delegate && [self.delegate respondsToSelector:@selector(commTFSelectView:didSelectItem:)]) {
        [self.delegate commTFSelectView:self didSelectItem:self.selectObject];
    }
}

@end
