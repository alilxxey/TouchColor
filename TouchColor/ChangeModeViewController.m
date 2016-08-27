//
//  ChangeModeViewController.m
//  TouchColor
//
//  Created by Александр Галкин on 10.06.16.
//  Copyright © 2016 iCoder. All rights reserved.
//

#import "ChangeModeViewController.h"

@interface ChangeModeViewController ()

@end

@implementation ChangeModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)presidentsModeButtonAction:(id)sender {

    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:1 forKey:@"РежимИгры"];
    [userDefaults synchronize];
}

- (IBAction)classicModeButtonAction:(id)sender {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:2 forKey:@"РежимИгры"];
    [userDefaults synchronize];
}

- (IBAction)animalsModeButtonAction:(id)sender {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:3 forKey:@"РежимИгры"];
    [userDefaults synchronize];
}
@end
