//
//  MenuViewController.m
//  TouchColor
//
//  Created by Александр Галкин on 23.11.15.
//  Copyright © 2015 iCoder. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load];
}

- (void)load {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    self.recoedMenuLabel.text = [NSString stringWithFormat:@"%ld", (long)[userDefaults integerForKey:@"Рекорд"]];
}

- (IBAction)actionRestartRecord:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Подтвердите обнуление"
                                                                   message:@"Вы хотите обнулить свой рекорд"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Да"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                                                              [userDefaults setInteger:0 forKey:@"Рекорд"];
                                                              [userDefaults synchronize];
                                                              [self load];
                                                          }];
    UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"Нет"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    [alert addAction:defaultAction];
    [alert addAction:defaultAction2];
    [self presentViewController:alert animated:YES completion:nil]; 
}

@end
