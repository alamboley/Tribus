//
//  NotificationUIControllerViewController.h
//  ChipmunkWrapper
//
//  Created by Mac on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationUIControllerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *notificationUILabel;
-(id) initWithText: (NSString*) text andLifeTime:(int) timeInMilliseconds;
@end
