//
//  APDataService.h
//  AnimalProtect
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APHTTPSession.h"
#import "APAPIConstants.h"
#import "NSString+APUtils.h"
#import "JSONModelLib.h"
#import "APHTTPResult.h"
#import "MJExtension.h"


typedef void(^APDataServiceSuccBlock)(void);

typedef void(^APDataServiceFailBlock)(NSError *error);

typedef void(^APDataServiceArraySuccBlock)(NSArray *array);

/**
 数据服务
 
 @author apem
 */
@interface APDataService : NSObject

@end
