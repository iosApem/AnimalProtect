//
//  CommSelectVC.h
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "APBaseVC.h"
#import "CommTFSelectObject.h"

@class CommSelectVC;

@protocol CommSelectVCDelegate<NSObject>
@optional
- (void)commSelectVC:(CommSelectVC *)commSelectVC dataDidSelect:(CommTFSelectObject *)data;
@end

@interface CommSelectVC : APBaseVC

@property (nonatomic, strong) CommTFSelectObject *selectData;
@property (nonatomic, strong) NSArray<CommTFSelectObject *> *dataArray;
@property (nonatomic, weak) id<CommSelectVCDelegate> delegate;

@end
