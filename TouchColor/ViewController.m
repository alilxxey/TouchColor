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
@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger money;
@property (assign, nonatomic) bool hardCoreOn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hardCoreOn = false;
    self.level = 1;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults integerForKey:@"scorePlus"] != 2) {
        [userDefaults setInteger:1 forKey:@"scorePlus"];
    }
    [userDefaults synchronize];
    self.scorePlus = [userDefaults integerForKey:@"scorePlus"];
    self.money = [userDefaults integerForKey:@"КоличествоДенег"];

    NSArray* viewsTouches = @[self.view1, self.view2, self.view3, self.view4, self.view5, self.view6];
    
    self.viewsTouches = viewsTouches;
    
    self.gameMode = [userDefaults integerForKey:@"РежимИгры"];
    // 2 - classic
    // 1 - presidents(custom)
    // 3 - animals
    
    if ([userDefaults integerForKey:@"РежимИгры"] == 2) {
        UIImage *image1 = [UIImage imageNamed:@"RED.png"];
        UIImage *image2 = [UIImage imageNamed:@"110.png"];
        UIImage *image3 = [UIImage imageNamed:@"YELLOW.png"];
        UIImage *image4 = [UIImage imageNamed:@"GREEN.png"];
        UIImage *image5 = [UIImage imageNamed:@"101.png"];
        UIImage *image6 = [UIImage imageNamed:@"BLUE.png"];
        self.colors = @[image1, image2, image3, image4, image5, image6];
    } else if ([userDefaults integerForKey:@"РежимИгры"] == 1){
        
        UIImage *image1 = [UIImage imageNamed:@"images-6.png"];
        UIImage *image2 = [UIImage imageNamed:@"images-5.png"];
        UIImage *image3 = [UIImage imageNamed:@"images-4.png"];
        UIImage *image4 = [UIImage imageNamed:@"images-3.png"];
        UIImage *image5 = [UIImage imageNamed:@"images-2.png"];
        UIImage *image6 = [UIImage imageNamed:@"images.png"];
        self.colors = @[image1, image2, image3, image4, image5, image6];
        for (UIImageView* view in self.viewsTouches) {
            view.image = [self.colors objectAtIndex:[self.viewsTouches indexOfObject:view]];
        }
    } else {
        UIImage *image1 = [UIImage imageNamed:@"animal-1.png"];
        UIImage *image2 = [UIImage imageNamed:@"animal-2.png"];
        UIImage *image3 = [UIImage imageNamed:@"animal-3.png"];
        UIImage *image4 = [UIImage imageNamed:@"animal-4.png"];
        UIImage *image5 = [UIImage imageNamed:@"animal-5.png"];
        UIImage *image6 = [UIImage imageNamed:@"animal-6.png"];
        self.colors = @[image1, image2, image3, image4, image5, image6];
        for (UIImageView* view in self.viewsTouches) {
            view.image = [self.colors objectAtIndex:[self.viewsTouches indexOfObject:view]];
        }
    }

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
    self.level = 1;
    self.timeLevel = 1;
    self.score = 0;
    self.chetLabel.text = @"0";
    [self start];
}

- (void)randColor {
    [UIView animateKeyframesWithDuration:0.3
                                   delay:0
                                 options:0
                              animations:^{
                                  self.levelLabel.alpha = 0;
                                  self.rView.alpha = 1;
                              } completion:^(BOOL finished) {
                              }];
    
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

- (void)newLevel {
    self.money += 20;
    self.timeLevel -= 0.07;
    self.level++;

    
    
    self.levelLabel.text = [NSString stringWithFormat:@"Уровень %ld", (long)self.level];
    [UIView animateKeyframesWithDuration:0.3
                                   delay:0
                                 options:0
                              animations:^{
                                  self.levelLabel.alpha = 1;
                                  self.rView.alpha = 0;
                              } completion:^(BOOL finished) {
                              }];
    
    [self.timer invalidate];
    [self start];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    
    UIImageView* touchView = [self.view hitTest:touchPoint withEvent:event];
    for (UIImageView* view in self.viewsTouches) {
        if ([view isEqual:touchView]) {
            self.money += 10;
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
                    [self newLevel];
                }
                if (self.score > [userDefaults integerForKey:@"Рекорд"]) {
                    [self save];
                }
            } else {
                AudioServicesPlaySystemSound(1488);
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
