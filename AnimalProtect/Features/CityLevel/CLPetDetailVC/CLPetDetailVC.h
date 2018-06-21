//
//  PetDetailVC.h
//  AnimalProtect
//
//  Created by apple on 2018/5/9.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APBaseVC.h"
#import "CLPetDog.h"

@class CLPetDetailVC;
@protocol CLPetDetailVCDelegate<NSObject>
@optional
- (void)clPetDetailVC:(CLPetDetailVC *)clPetDetailVC didSavePet:(CLPetDog *)pet;
@end

/**
 宠物详情
 
 @author apem
 */
@interface CLPetDetailVC : APBaseVC

@property (nonatomic, strong) NSString *dogID;      //犬ID     (编辑必须)
@property (nonatomic, strong) NSString *ownerNo;    //犬主编号 (新增必须)
@property (nonatomic, weak) id<CLPetDetailVCDelegate> delegate;

@end
