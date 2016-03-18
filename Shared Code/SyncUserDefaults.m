//
//  SyncUserDefaults.m
//  SyncUserDefaults
//
//  Created by Theo Scott on 18/03/2016.
//  Copyright © 2016 Theo Scott. All rights reserved.
//

#import "SyncUserDefaults.h"
#import <WatchConnectivity/WatchConnectivity.h>

static NSString *const kSyncUserDefaultsKey=@"SyncUserDefaultsKey";

@implementation SyncUserDefaults

+ (SyncUserDefaults *)standardUserDefaults
{
    static SyncUserDefaults *Manager=nil;
    static dispatch_once_t Token;
    dispatch_once (&Token,
                   ^{
                       Manager= [[self alloc] init];
                       
                       
                   });
    return Manager;
}

- (BOOL)synchronize
{
    NSLog(@"Local synchronize");
    BOOL returnCode=[super synchronize];
    
    if (!returnCode)
        return returnCode; // synchronize has failed
    
    WCSession *session =[WCSession defaultSession];
    NSLog(@"companion synchronize");

    [self pushValues:session];
    
    return returnCode;
    
    
}

- (NSSet *) getKeysToSyncronizeWithCompanion
{
    NSSet *keys = [NSSet setWithArray:@[@"Value1", @"Value3"]];
    return keys;
    
}

- (NSString *) syncUserDefaultsKeyName
{
    return kSyncUserDefaultsKey;
}

#pragma mark - sender part
- (NSDictionary *) exportedDefaultsForCompanion
{
    
    NSSet *keys = [self getKeysToSyncronizeWithCompanion]; // set of keys that need to be synced
    NSMutableDictionary *exportedSettings = [[NSMutableDictionary alloc] initWithCapacity:keys.count];
    
    for (NSString *key in keys)
    {
        id object = [self objectForKey:key];
        
        if (object != nil)
        {
            [exportedSettings setObject:object forKey:key];
        }
    }
    
    return [exportedSettings copy];
}


- (void) pushValues:(WCSession *) session
{
    
   
    NSDictionary *exportedDefaults = [self exportedDefaultsForCompanion];
    if (exportedDefaults == nil)
    {
        exportedDefaults = @{ }; //send nothing, in other words clear companion defaults
    }
    NSDictionary *syncDefaults = @{kSyncUserDefaultsKey: exportedDefaults };
    
    dispatch_async(dispatch_get_main_queue(), ^{
         NSError *error;
        [session updateApplicationContext:syncDefaults error:&error];
        
        // Handle  errors below...
        
        //code
    });
   
}




- (void)importValuesFromCompanionApp:(NSDictionary *) syncedUserDefaults
{
    
    
    NSSet *keys = [self getKeysToSyncronizeWithCompanion]; // set of keys that need to be synced
    for (NSString *key in keys)
    {
        id object = [syncedUserDefaults objectForKey:key];
        if (object != nil)
        {
            [self setObject:object forKey:key];
        }
        else
        {
            [self removeObjectForKey:key];
        }
    }
    
    [super synchronize];
}

#pragma mark - receiver snippet

// Place the below in both the iPhone (ViewController.m) and WAtchOS (InterfaceController.m) targets.

/*
 - (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)userInfo
 {
     NSDictionary *syncDic = [userInfo objectForKey:kSyncUserDefaults];
     if (syncDic != nil)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
                     [UserDefaults  importValuesFromCompanionApp:settings];
                     [self readDefaults];
 
         });
     }
 }
*/

@end
