//
//  InterfaceController.m
//  SyncUserDefaults WatchKit Extension
//
//  Created by Theo Scott on 16/03/2016.
//  Copyright © 2016 Theo Scott. All rights reserved.
//

#import "InterfaceController.h"
#import "SyncUserDefaults.h"
#import <WatchConnectivity/WatchConnectivity.h>


@interface InterfaceController() <WCSessionDelegate>
{
}

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if ([WCSession isSupported])
    {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    [self readDefaults];


    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)changeSwitchValue:(BOOL)value
{
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    [UserDefaults setBool:value forKey:@"Value1"];
    
}

- (IBAction)changeSliderValue:(float)value {
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    [UserDefaults setFloat:value forKey:@"Value3"];
}

- (IBAction)sync {
    
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    [UserDefaults synchronize];
}


- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext;
{
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    NSLog(@"Watch received values");
    NSDictionary *settings = [applicationContext objectForKey:[UserDefaults syncUserDefaultsKeyName] ];
    if (settings != nil)
    {
        // Import the settings
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UserDefaults  importValuesFromCompanionApp:settings];
            [self readDefaults];
        });
        
        
        
    }
}

- (void) readDefaults
{
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];

    [self.value1 setOn:[UserDefaults boolForKey:@"Value1"]];
    [self.value2 setText:[UserDefaults objectForKey:@"Value2"]];
    [self.value3 setValue:[UserDefaults floatForKey:@"Value3"]];
}

          

 
@end



