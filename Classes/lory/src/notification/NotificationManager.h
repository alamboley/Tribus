//
//  NotificationManager.h
//  ChipmunkWrapper
//
//  Created by Mac on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationManager : NSObject

+ (void)initManager;
+ (void)addNotificationWithText: (NSString*) text andLifeTime: (int) timeInMilliseconds;
+ (void)destroyManager;

+ (NSMutableArray*) getNotifications;
@end
