//
//  CommSelectVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "CommSelectVC.h"
#import "CommSelectVCCell.h"

@interface CommSelectVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tb;

@end

@implementation CommSelectVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initSubviews
{
    [super initSubviews];
    
    self.navigationItem.title = @"请选择";
    
    NSString *className = NSStringFromClass([CommSelectVCCell class]);
    [self.tb registerClass:[CommSelectVCCell class] forCellReuseIdentifier:className];
    [self.tb reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = NSStringFromClass([CommSelectVCCell class]);
    CommSelectVCCell *cell = [[CommSelectVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    
    CommTFSelectObject *record = [self.dataArray objectAtIndex:indexPath.row];
    [cell setObj:record];
    
    if ([self.selectData.NAME isEqualToString:record.NAME] == YES) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommTFSelectObject *record = [self.dataArray objectAtIndex:indexPath.row];
    
    self.selectData = record;
    [self.tb reloadData];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(commSelectVC:dataDidSelect:)]) {
        [self.delegate commSelectVC:self dataDidSelect:record];
    }
}

@end

