//
//  ViewController.m
//  SyncUserDefaults
//
//  Created by Theo Scott on 16/03/2016.
//  Copyright © 2016 Theo Scott. All rights reserved.
//

#import "ViewController.h"
#import "SyncUserDefaults.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface ViewController ()  <WCSessionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if ([WCSession isSupported])
    {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    [self readDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)changeSwitchValue:(id)sender {
    BOOL value=[self.value1 isOn];
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    [UserDefaults setBool:value forKey:@"Value1"];

}

- (IBAction)changeSliderValue:(id)sender {
    float value=[self.value3 value];
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    [UserDefaults setFloat:value forKey:@"Value3"];
}

- (IBAction)changeTextValue:(id)sender {
    
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    [UserDefaults setObject:self.value2.text  forKey:@"Value2"];
}

- (IBAction)sync:(id)sender
{
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    
    [UserDefaults synchronize];
    
    
}

- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext;
{
    SyncUserDefaults *UserDefaults=[SyncUserDefaults standardUserDefaults];
    NSLog(@"iPhone received values");
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
