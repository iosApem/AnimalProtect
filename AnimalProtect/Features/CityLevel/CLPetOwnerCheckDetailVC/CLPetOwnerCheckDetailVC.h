//
//  CLPetOwnerCheckDetailVC.h
//  AnimalProtect
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APBaseVC.h"
#import "CLPetOwner.h"

@class CLPetOwnerCheckDetailVC;
@protocol CLPetOwnerCheckDetailVCDelegate<NSObject>
@optional
//宠物主被审核
- (void)clPetOwnerCheckDetailVC:(CLPetOwnerCheckDetailVC *)clPetOwnerCheckDetailVC ownerDidCheck:(CLPetOwner *)owner;
@end

/**
 犬主审核详情
 
 @author apem
 */
@interface CLPetOwnerCheckDetailVC : APBaseVC

@property (nonatomic, strong) NSString *ownerID; //犬主编号
@property (nonatomic, weak) id<CLPetOwnerCheckDetailVCDelegate> delegate;

@end
