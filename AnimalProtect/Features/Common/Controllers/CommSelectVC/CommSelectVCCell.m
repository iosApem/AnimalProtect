//
//  CommSelectVCCell.m
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CommSelectVCCell.h"

@implementation CommSelectVCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setObj:(CommTFSelectObject *)obj
{
    _obj = obj;
    self.textLabel.text = _obj.NAME;
    
}

@end
