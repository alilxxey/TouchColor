//
//  ViewController.m
//  TouchColor
//
//  Created by Александр Галкин on 05.11.15.
//  Copyright © 2015 iCoder. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@property (retain, nonatomic) NSTimer* timer;
@property (strong, nonatomic) NSString* lastColor;
@property (strong, nonatomic) NSArray* viewsTouches;
@property (strong, nonatomic) NSArray* colors;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) float timeLevel;
@property (assign, nonatomic) NSInteger scorePlus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults integerForKey:@"scorePlus"] != 2) {
        [userDefaults setInteger:1 forKey:@"scorePlus"];
    }
    [userDefaults synchronize];
    self.scorePlus = [userDefaults integerForKey:@"scorePlus"];
    
    NSArray* viewsTouches = @[self.view1, self.view2, self.view3, self.view4, self.view5, self.view6];
    self.viewsTouches = viewsTouches;
    
    NSArray* colors = @[@"100", @"101", @"110", @"010", @"011", @"001"];
    self.colors = colors;
    
    [self load];
    [self restart];
}

- (void)start {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeLevel
                                     target:self
                                   selector:@selector(randColor)
                                   userInfo:NULL
                                    repeats:YES];
}

- (void)restart {
    self.timeLevel = 1;
    self.score = 0;
    self.chetLabel.text = @"0";
    [self start];
}

- (void)randColor {
    NSString* randColor = [self.colors objectAtIndex:arc4random() % 6];
    
    while ([randColor isEqual:self.lastColor]) {
        randColor = [self.colors objectAtIndex:arc4random() % 6];
        
    }
    
    int randColorInt = [randColor intValue];
    self.lastColor = randColor;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.rView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.rView.backgroundColor = [UIColor colorWithRed:randColorInt / 100
                                                     green:randColorInt / 10 % 10
                                                      blue:randColorInt  % 10
                                                     alpha:1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.rView.transform = CGAffineTransformMakeScale(1, 1);
                         }];
    }];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    UIView* touchView = [self.view hitTest:touchPoint withEvent:event];
    for (UIView* view in self.viewsTouches) {
        if ([view isEqual:touchView]) {
            
            [UIView animateWithDuration:0.2 animations:^{
                view.transform = CGAffineTransformMakeScale(0.5 , 0.5);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     view.transform = CGAffineTransformMakeScale(1, 1);
                                 }];
            }];
            
            NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
            if ([self.viewsTouches indexOfObject:view] == [self.colors indexOfObject:self.lastColor]) {
                self.score += self.scorePlus;
                self.chetLabel.text = [NSString stringWithFormat:@"%ld", (long)self.score];
                AudioServicesPlaySystemSound(1446);
                if (self.score % 10 == 0) {
                    self.timeLevel -= 0.07;
                    [self.timer invalidate];
                    [self start];
                }
                if (self.score > [userDefaults integerForKey:@"Рекорд"]) {
                    [self save];
                }
            } else {
                AudioServicesPlaySystemSound(1301);
                if (self.score == [userDefaults integerForKey:@"Рекорд"] && self.score != 0) {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Неплохо"
                                                                                   message:@"Рекорд побит"
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"ОК" style:UIAlertActionStyleDefault
                                                                          handler:^(UIAlertAction * action) {
                                                                          
                                                                          }];
                    
                    [alert addAction:defaultAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                [self.timer invalidate];
                [self restart];
            }
        }
    }
}


-(void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)save {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.score forKey:@"Рекорд"];
    [userDefaults synchronize];
    [self load];
}

- (void)load {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    self.recordLabel.text = [NSString stringWithFormat:@"%ld", (long)[userDefaults integerForKey:@"Рекорд"]];
}

@end
