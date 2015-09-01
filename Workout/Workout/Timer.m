//
//  Timer.m
//  Workout
//
//  Created by Steven Hao on 9/1/15.
//  Copyright (c) 2015 Catheryn Li. All rights reserved.
//

#import "Timer.h"

@interface Timer ()

@property (nonatomic) NSTimeInterval timeRemaining;
@property (readonly) BOOL running;
@property (nonatomic) id<TimerDelegate> delegate;
@property (retain) NSDate *lastTimeCheck;
@property (retain) NSTimer *updateManager;

@end

#define updateFrequency 0.001

@implementation Timer

- (instancetype)initWithTime:(NSTimeInterval)seconds
            delegate:(id<TimerDelegate>)delegate {
    if (self = [super init]) {
        _delegate = delegate;
        _timeRemaining = seconds;
    }
    return self;
}

- (void)start {
    _lastTimeCheck = [NSDate date];
    _running = true;
    _updateManager = [NSTimer scheduledTimerWithTimeInterval:updateFrequency target:self selector:@selector(update) userInfo:nil repeats:true];
}

- (void)update {
    if (_running) {
        NSDate *curDate = [NSDate date];
        NSTimeInterval elapsed = [curDate timeIntervalSinceDate:_lastTimeCheck];
        _lastTimeCheck = curDate;
        _timeRemaining -= elapsed;
        if (_timeRemaining < 0) {
            _timeRemaining = 0;
        }
        
        if (_timeRemaining == 0) {
            _running = false;
            [self fireEvent];
        }
        
        if (_delegate) {
            [_delegate timerDidUpdate];
        }
    }
}

- (void)pause {
    [self update];
    [_updateManager invalidate];
    _running = false;
}

- (void)setTime:(NSTimeInterval)seconds {
    _timeRemaining = seconds;
}

- (NSTimeInterval) getTime {
    return _timeRemaining;
}

- (void)fireEvent {
    [_delegate timerDidFire];
}
@end
