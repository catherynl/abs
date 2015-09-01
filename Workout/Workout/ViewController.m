//
//  ViewController.m
//  Workout
//
//  Created by Catheryn Li on 8/31/15.
//  Copyright (c) 2015 Catheryn Li. All rights reserved.
//

#import "ViewController.h"

#define default_time 10.0

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) Timer *timer;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (nonatomic, assign) int exerciseNumber;
@property (nonatomic, copy) NSArray *exerciseArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startButton.hidden = NO;
    self.stopButton.hidden = YES;
    self.exerciseLabel.text = @"Ready to exercise?";
    // Set up exercise list
    NSArray *array = @[@"Crunches", @"In-and-outs", @"Side crunches L", @"Side crunches R", @"Mini Vs", @"Bicycles", @"Big Vs", @"Sitting", @"Plank", @"Side plank L", @"Side plank R"];
    self.exerciseArray = array;
    [self makeAudioPlayer];
    [self makeTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: Starting & stopping workout

- (IBAction)startButtonPressed:(id)sender {
    [self startTimer];
    self.startButton.hidden = YES;
    self.stopButton.hidden = NO;

}

- (IBAction)stopButtonPressed:(id)sender {
    self.stopButton.hidden = YES;
    self.startButton.hidden = NO;
    [self stopTimer];
}

// MARK: Timer

- (void)makeTimer {
    NSLog(@"Make timer");
    _timer = [[Timer alloc] initWithTime:default_time delegate:self];
}

- (void)resetTimer {
    [_timer setTime:default_time];
}

- (void)startTimer {
    self.exerciseLabel.text = self.exerciseArray[self.exerciseNumber];
    [_timer start];
}

- (void)stopTimer {
    [_timer pause];
}

- (void)endWorkout {
}


- (void) timerDidUpdate {
//    NSLog(@"Timer update");
    NSTimeInterval interval = [_timer getTime];
    int sec = (int)interval;
    int millis = (int) ((interval - sec) * 1000);
    NSString* str = [[NSString alloc] initWithFormat:@"%02d.%03d", sec, millis];
    _countdownLabel.text = str;
}

- (void)timerDidFire {
    NSLog(@"Timer fire");
    [self playSound];
    self.exerciseNumber++;
    [self resetTimer];
    [self startTimer];
    if (self.exerciseNumber < 11) {
        [self startTimer];
    } else {
        [self endWorkout];
    }
}

// MARK: Sound

- (void) makeAudioPlayer {
    NSLog(@"Make audio player");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"beep-scratchy" ofType:@"aif"];
    NSURL *URL = [NSURL fileURLWithPath:path];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
    [self.audioPlayer prepareToPlay];
}

- (void)playSound {
    NSLog(@"Play sound");
    [self.audioPlayer play];
    [self.audioPlayer prepareToPlay];
    
}

@end
