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
@property (assign, nonatomic) NSInteger lastIndexRandImage;
@property (strong, nonatomic) NSArray* viewsTouches;
@property (strong, nonatomic) NSArray* colors;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) float timeLevel;
@property (assign, nonatomic) NSInteger scorePlus;
@property (assign, nonatomic) NSInteger gameMode;

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
    
//    self.gameMode = [userDefaults integerForKey:@"РежимИгры"];
//    
//    if (self.gameMode == 1) {
//        UIImage *image1 = [UIImage imageNamed:@"RED.png"];
//        UIImage *image2 = [UIImage imageNamed:@"110.png"];
//        UIImage *image3 = [UIImage imageNamed:@"YELLOW.png"];
//        UIImage *image4 = [UIImage imageNamed:@"GREEN.png"];
//        UIImage *image5 = [UIImage imageNamed:@"101.png"];
//        UIImage *image6 = [UIImage imageNamed:@"BLUE.png"];
//        self.colors = @[image1, image2, image3, image4, image5, image6];
//    } else if (self.gameMode == 2){
//        UIImage *image1 = [UIImage imageNamed:@"MLG1.png"];
//        UIImage *image2 = [UIImage imageNamed:@"MLG2.png"];
//        UIImage *image3 = [UIImage imageNamed:@"MLG_logo.png"];
//        UIImage *image4 = [UIImage imageNamed:@"MLG4.png"];
//        UIImage *image5 = [UIImage imageNamed:@"MLG5.png"];
//        UIImage *image6 = [UIImage imageNamed:@"MLG6.png"];
//        self.colors = @[image1, image2, image3, image4, image5, image6];
//    } else {
//        UIImage *image1 = [UIImage imageNamed:@"RED.png"];
//        UIImage *image2 = [UIImage imageNamed:@"110.png"];
//        UIImage *image3 = [UIImage imageNamed:@"YELLOW.png"];
//        UIImage *image4 = [UIImage imageNamed:@"GREEN.png"];
//        UIImage *image5 = [UIImage imageNamed:@"101.png"];
//        UIImage *image6 = [UIImage imageNamed:@"BLUE.png"];
//        self.colors = @[image1, image2, image3, image4, image5, image6];
//    }
    
    
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
    
    int indexRandImage = arc4random() % 6;
    while (indexRandImage == self.lastIndexRandImage) {
        indexRandImage = arc4random() % 6;
    }
    self.lastIndexRandImage = indexRandImage;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.rView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.rView.image = [self.colors objectAtIndex:indexRandImage];
        
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
    
    UIImageView* touchView = [self.view hitTest:touchPoint withEvent:event];
    for (UIImageView* view in self.viewsTouches) {
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
            if ([self.viewsTouches indexOfObject:view] == self.lastIndexRandImage) {
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
