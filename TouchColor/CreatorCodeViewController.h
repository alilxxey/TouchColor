//
//  CreatorCodeViewController.h
//  TouchColor
//
//  Created by Александр Галкин on 23.11.15.
//  Copyright © 2015 iCoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatorCodeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *creatorCodeField;

- (IBAction)actionCreatorCode:(id)sender;
- (IBAction)actionReset:(id)sender;

@end
