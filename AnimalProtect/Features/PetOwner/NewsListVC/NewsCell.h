//
//  NewsCell.h
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLNews.h"

@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *dateL;

@property (nonatomic, strong) CLNews *news;

@end
