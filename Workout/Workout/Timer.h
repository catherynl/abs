//
//  Timer.h
//  Workout
//
//  Created by Steven Hao on 9/1/15.
//  Copyright (c) 2015 Catheryn Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimerDelegate <NSObject>

- (void)timerDidUpdate;
- (void)timerDidFire;

@end

@interface Timer : NSObject

- (instancetype)initWithTime:(NSTimeInterval)seconds
          delegate:(id<TimerDelegate>)delegate;
- (void)start;
- (void)pause;
- (void)setTime:(NSTimeInterval)seconds;
- (NSTimeInterval)getTime;

@end
