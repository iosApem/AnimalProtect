//
//  APNews.h
//  AnimalProtect
//
//  Created by apple on 2018/5/10.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 时事新闻
 
 @author apem
 */
@interface CLNews : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *modifTime;
@property (nonatomic, strong) NSString *content;

@end
