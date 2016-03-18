//
//  SyncUserDefaults.h
//  SyncUserDefaults
//
//  Created by Theo Scott on 18/03/2016.
//  Copyright © 2016 Theo Scott. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyncUserDefaults : NSUserDefaults

+ (SyncUserDefaults *)standardUserDefaults;
- (BOOL)synchronize;
- (NSString *) syncUserDefaultsKeyName;
- (void)importValuesFromCompanionApp:(NSDictionary *) syncedUserDefaults;

@end
