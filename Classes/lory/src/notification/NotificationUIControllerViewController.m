//
//  NotificationUIControllerViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "NotificationUIControllerViewController.h"

@interface NotificationUIControllerViewController ()

@end

@implementation NotificationUIControllerViewController
@synthesize notificationUILabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id) initWithText: (NSString*) text andLifeTime:(int) timeInMilliseconds{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNotificationUILabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
