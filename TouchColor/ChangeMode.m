//
//  ChangeMode.m
//  TouchColor
//
//  Created by ALEXEY TYUNKIN on 04.02.16.
//  Copyright © 2016 iCoder. All rights reserved.
//

#import "ChangeMode.h"

@implementation ChangeMode

- (IBAction)ActionClassicMode:(id)sender {
    //Classic Mode = 1
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"РежимИгры"];
    [userDefaults synchronize];

}

- (IBAction)ActionMLGMode:(id)sender {
    //MLG mode = 2
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:2 forKey:@"РежимИгры"];
    [userDefaults synchronize];
}

@end
