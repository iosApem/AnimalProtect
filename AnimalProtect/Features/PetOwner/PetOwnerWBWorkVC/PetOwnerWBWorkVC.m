//
//  WBWorkVC.m
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "PetOwnerWBWorkVC.h"
#import "TopImgTitleView.h"
#import "CLPetOwnerEditVC.h"
#import "CLPetListVC.h"
#import "NewsListVC.h"
#import "CLPetImmuneListVC.h"
#import "APUsers.h"

@interface PetOwnerWBWorkVC ()<TopImgTitleViewDelegate>

@property (weak, nonatomic) IBOutlet TopImgTitleView *personInfoV;
@property (weak, nonatomic) IBOutlet TopImgTitleView *dogInfoV;
@property (weak, nonatomic) IBOutlet TopImgTitleView *protectRecordV;
@property (weak, nonatomic) IBOutlet TopImgTitleView *newsV;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PetOwnerWBWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"宠物主角色";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TopImgTitleViewDelegate

- (void)topImgTitleViewDidTap:(TopImgTitleView *)topImgTitleView
{
    APUsers *users = [APUsers currentUser];
    //个人信息
    if (topImgTitleView == self.personInfoV) {
        CLPetOwnerEditVC *vc = [[CLPetOwnerEditVC alloc] init];
        
        vc.petOwnerID = users.id;
        vc.type = CLPetOwnerEditVCTypeSee;
        [self.navigationController pushViewController:vc animated:YES];
    //犬信息
    } else if (topImgTitleView == self.dogInfoV) {
        CLPetListVC *vc = [[CLPetListVC alloc] init];
        vc.ownerNo = users.ownerNo;
        [self.navigationController pushViewController:vc animated:YES];
    //免疫记录
    } else if (topImgTitleView == self.protectRecordV) {
        CLPetImmuneListVC *vc = [[CLPetImmuneListVC alloc] init];
        vc.ownerNo = users.ownerNo;
        [self.navigationController pushViewController:vc animated:YES];

    //最新实事
    } else if (topImgTitleView == self.newsV) {
        NewsListVC *vc = [[NewsListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
