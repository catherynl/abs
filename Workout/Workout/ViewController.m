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
@property (nonatomic, assign) int exerciseNumber;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) Timer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeAudioPlayer];
    [self makeTimer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender {
    [self startTimer];
}

- (IBAction)stopButtonPressed:(id)sender {
    [self stopTimer];
}

- (void)makeAudioPlayer {
    NSLog(@"Make audio player");
    NSString *path = [[NSBundle mainBundle] pathForResource: @"beep-scratchy" ofType: @"aif"];
    //    NSLog("Path = \(path)")
    NSURL *URL = [NSURL fileURLWithPath:path];
    //    let URL = NSURL.fileURLWithPath(path!)
    //    NSLog("URL = \(URL)")
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: URL error: nil];
    [self.audioPlayer prepareToPlay];
}

- (void)makeTimer {
    NSLog(@"Make timer");
    _timer = [[Timer alloc] initWithTime:default_time delegate:self];
}

- (void)resetTimer {
    [_timer setTime:default_time];
}

- (void)startTimer {
    [_timer start];
}

- (void)stopTimer {
    [_timer pause];
}

- (void)playSound {
    NSLog(@"Play sound");

    [self.audioPlayer play];
//    NSLog("Play result: \(audioPlayer.play())")
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
    // Sound goes off
    self.exerciseNumber++;
    [self resetTimer];
    [self startTimer];
}

@end
