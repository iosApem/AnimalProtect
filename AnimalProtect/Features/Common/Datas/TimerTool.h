//
//  TimerTool.h
//  AnimalProtect
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 apem. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TimerTool;
@protocol TimerToolDelegate <NSObject>
@optional

/**
 计时器每秒回调

 @param timerTool 计时器
 @param currentSecond 当前秒数
 @param complete 是否计时结束
 */
- (void)timerTool:(TimerTool *)timerTool currentSecond:(NSInteger)currentSecond complete:(BOOL)complete;
@end

/**
 计时工具
 
 @author apem
 */
@interface TimerTool : NSObject

@property (nonatomic, assign, readonly) NSInteger second;
@property (nonatomic, weak) id<TimerToolDelegate> delegate;

- (instancetype)initWithSecond:(NSInteger)second;

- (void)start;

@end
