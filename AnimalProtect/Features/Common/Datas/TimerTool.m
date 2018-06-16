//
//  TimerTool.m
//  AnimalProtect
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 apem. All rights reserved.
//

#import "TimerTool.h"

@interface TimerTool()

@property (nonatomic, assign) NSInteger currentSecond;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TimerTool

@synthesize second = _second;

- (instancetype)initWithSecond:(NSInteger)second
{
    if(self = [super init]) {
        _second = second;
        self.currentSecond = 0;
        
    }
    return self;
}

- (void)start
{
    [self cancellationTimer];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)dealloc
{
    [self cancellationTimer];
}

- (void)cancellationTimer
{
    if(self.timer != nil) {
        if ([self.timer isValid] == YES) {
            [self.timer invalidate];
        }
    }
    
    self.timer = nil;
}

#pragma mark - IBAction

- (void)timerAction:(NSTimer *)timer
{
    BOOL complete = NO;
    
    self.currentSecond ++;
    if (self.currentSecond == self.second) {
        [self cancellationTimer];
        
        self.currentSecond = 0;
        
        complete = YES;
    } else {
        complete = NO;
    }
    
    //回调
    if (self.delegate && [self.delegate respondsToSelector:@selector(timerTool:currentSecond:complete:)]) {
        [self.delegate timerTool:self currentSecond:self.currentSecond complete:complete];
    }
}

@end
