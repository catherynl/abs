//
//  ViewController.m
//  Workout
//
//  Created by Catheryn Li on 8/31/15.
//  Copyright (c) 2015 Catheryn Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *exerciseLabel;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, assign) int exerciseNumber;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeAudioPlayer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender {
    [self startTimer];
    self.exerciseNumber = 0;
}

- (void) makeAudioPlayer {
    NSLog(@"Make audio player");
    NSString *path = [[NSBundle mainBundle] pathForResource: @"beep-scratchy" ofType: @"aif"];
    //    NSLog("Path = \(path)")
    NSURL *URL = [NSURL fileURLWithPath:path];
    //    let URL = NSURL.fileURLWithPath(path!)
    //    NSLog("URL = \(URL)")
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: URL error: nil];
    [self.audioPlayer prepareToPlay];
}

- (void)startTimer {
    if (self.exerciseNumber < 10) {
        NSLog(@"Starting Timer.");
        [NSTimer scheduledTimerWithTimeInterval:10.0
                                         target:self
                                       selector:@selector(timerWentOff)
                                       userInfo:nil
                                        repeats:NO];
    }
}

- (void)playSound {
    NSLog(@"Play sound");

    [self.audioPlayer play];
//    NSLog("Play result: \(audioPlayer.play())")
}

- (void)timerWentOff {
    [self playSound];
    // Sound goes off
    self.exerciseNumber++;
    [self startTimer];
}

@end
