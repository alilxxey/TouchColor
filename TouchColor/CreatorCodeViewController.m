//
//  CreatorCodeViewController.m
//  TouchColor
//
//  Created by Александр Галкин on 23.11.15.
//  Copyright © 2015 iCoder. All rights reserved.
//

#import "CreatorCodeViewController.h"

@interface CreatorCodeViewController ()

@property (strong, nonatomic) NSString* creatorCode;


@end

@implementation CreatorCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)actionCreatorCode:(id)sender {
    self.creatorCode = @"4812995";
    
    if ([self.creatorCodeField.text isEqual:self.creatorCode]){
        self.view.backgroundColor = [UIColor greenColor];
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:2 forKey:@"scorePlus"];
        [userDefaults setInteger:99999999 forKey:@"Рекорд"];
        [userDefaults synchronize];
        self.view.backgroundColor = [UIColor greenColor];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Отлично!!!"
                                                                       message:@"Вы ввели верный код разработчика!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"УPAAA" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        self.view.backgroundColor = [UIColor redColor];
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setInteger:0 forKey:@"Рекорд"];
        [userDefaults setInteger:1 forKey:@"scorePlus"];
        [userDefaults synchronize];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Неплохая попытка!"
                                                                       message:@"Хорошая попытка отгадать код! Попробуйте ещё. И кстати, за попытку у Вас обнуляется рекорд ;)"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"ОК :(" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                              }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
     }
}

- (IBAction)actionReset:(id)sender {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:0 forKey:@"Рекорд"];
    [userDefaults setInteger:1 forKey:@"scorePlus"];
    [userDefaults synchronize];
}
@end
