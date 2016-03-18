//
//  ViewController.h
//  SyncUserDefaults
//
//  Created by Theo Scott on 16/03/2016.
//  Copyright © 2016 Theo Scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *value1;
@property (weak, nonatomic) IBOutlet UITextField *value2;
@property (weak, nonatomic) IBOutlet UISlider *value3;
- (IBAction)sync:(id)sender;
- (IBAction)changeSwitchValue:(id)sender;
- (IBAction)changeSliderValue:(id)sender;
- (IBAction)changeTextValue:(id)sender;

@end

