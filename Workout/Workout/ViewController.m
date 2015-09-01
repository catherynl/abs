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
@property (nonatomic, assign) NSInteger *exerciseNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)startTimer {
    if (self.exerciseNumber < 10) {
        [NSTimer scheduledTimerWithTimeInterval:30.0
                                         target:self
                                       selector:@selector(timerWentOff)
                                       userInfo:nil
                                        repeats:NO];
    }
}

- (void)timerWentOff {
    // Sound goes off
    self.exerciseNumber++;
    [self startTimer];
}

@end
