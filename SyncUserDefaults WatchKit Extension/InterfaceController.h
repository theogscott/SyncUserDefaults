//
//  InterfaceController.h
//  SyncUserDefaults WatchKit Extension
//
//  Created by Theo Scott on 16/03/2016.
//  Copyright © 2016 Theo Scott. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceSwitch *value1;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *value2;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceSlider *value3;
- (IBAction)changeSwitchValue:(BOOL)value;
- (IBAction)changeSliderValue:(float)value;

- (IBAction)sync;
@end
