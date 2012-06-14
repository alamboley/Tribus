//
//  MainUIViewController.h
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ColorUIViewController.h"
#import "NotificationUIViewControllerViewController.h"

@interface MainUIViewController : UIViewController{
    NotificationUIViewControllerViewController *notif;
    int minutesLeft;
}
@property (weak, nonatomic) IBOutlet UILabel *nextBusUILabel;
@property (nonatomic, retain) ColorUIViewController *colorUIViewController;

@end
