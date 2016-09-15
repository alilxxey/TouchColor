//
//  MenuViewController.h
//  TouchColor
//
//  Created by Александр Галкин on 23.11.15.
//  Copyright © 2015 iCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *moneyMenuLabel;
@property (weak, nonatomic) IBOutlet UILabel *recoedMenuLabel;

- (IBAction)actionRestartRecord:(id)sender;


@end
