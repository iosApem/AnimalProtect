//
//  PersonInfoVC.h
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APBaseVC.h"
#import "CLPetOwner.h"

/**
 宠物主信息页面类型
 */
typedef enum {
    CLPetOwnerEditVCTypeEdit = 0x00, //编辑
    CLPetOwnerEditVCTypeSee = 0x01,  //查看
}CLPetOwnerEditVCType;

@class CLPetOwnerEditVC;
@protocol CLPetOwnerEditVCDelegate<NSObject>
@optional
//点击保存
- (void)clPetOwnerEditVC:(CLPetOwnerEditVC *)clPetOwnerEditVC didSaveOwner:(CLPetOwner *)owner;
@end

/**
 宠物主信息 (新增/编辑 个人信息查看 个人信息初始化)
 
 @author apem
 */
@interface CLPetOwnerEditVC : APBaseVC

@property (nonatomic, strong) NSString *petOwnerID;        //宠物主ID
@property (nonatomic, assign) CLPetOwnerEditVCType type;   //类型
@property (nonatomic, weak) id<CLPetOwnerEditVCDelegate> delegate;
@end
