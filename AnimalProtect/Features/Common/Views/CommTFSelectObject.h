//
//  CommTFSlelectObject.h
//  AnimalProtect
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 通用的选择或输入视图选择对象
 
 @author apem
 */
@interface CommTFSelectObject : NSObject

@property (nonatomic, strong) NSString *CODE;
@property (nonatomic, strong) NSString *NAME;
@property (nonatomic, strong) id data;

+ (instancetype)objWithCode:(NSString *)code name:(NSString *)name;

@end
