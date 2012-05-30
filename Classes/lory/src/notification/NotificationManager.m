//
//  NotificationManager.m
//  ChipmunkWrapper
//
//  Created by Mac on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "NotificationManager.h"
#import "NotificationUIControllerViewController.h"
@implementation NotificationManager
static NSMutableDictionary *notifications = nil;

+ (void)initManager{
    notifications = [[NSMutableDictionary alloc] init];
}
+ (void)destroyManager{
    [notifications removeAllObjects];
    notifications = nil;
}

+ (void)addNotificationWithText: (NSString*) text andLifeTime: (int) timeInMilliseconds{
    NotificationUIControllerViewController *notif = [[NotificationUIControllerViewController alloc] init];
    [notifications setValue:notif forKey:[NSString stringWithFormat:@"%d",rand()]];
}
+ (NSMutableDictionary*) getNotifications{
    return notifications;
}

@end
