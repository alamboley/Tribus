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
static NSMutableArray *notifications = nil;

+ (void)initManager{
    notifications = [[NSMutableArray alloc] init];
}
+ (void)destroyManager{
    [notifications removeAllObjects];
    notifications = nil;
}

+ (void)addNotificationWithText: (NSString*) text andLifeTime: (int) timeInMilliseconds{
    NotificationUIControllerViewController *notif = [[NotificationUIControllerViewController alloc] initWithText:text andLifeTime:timeInMilliseconds];
    [notifications addObject:notif];
}
+ (NSMutableArray*) getNotifications{
    return notifications;
}

@end
