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
#import "APHTTPResult.h"
#import "MJExtension.h"
#import "Hbb_JSONParser.h"


typedef void(^APDataServiceSuccBlock)(void);

typedef void(^APDataServiceFailBlock)(NSError *error);

typedef void(^APDataServiceArraySuccBlock)(NSArray *array);

/**
 数据服务
 
 @author apem
 */
@interface APDataService : NSObject

@property (nonatomic, strong) Hbb_JSONParser *jsonParser;

@end
