//
//  MainUINavigationControllerViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 03/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "MainUINavigationControllerViewController.h"
#import "PRTween.h"

@interface MainUINavigationControllerViewController ()

@end

@implementation MainUINavigationControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)busIncomingHandler: (NSNotification *) notification
{
    notif = [[NotificationUIViewControllerViewController alloc] initWithNibName:@"NotificationUIViewControllerViewController" bundle:nil];
    CGRect frame = [notif.view frame];
    frame.origin.x = 370.0f;
    frame.origin.y -= 50.0f;
    [notif.view setFrame:frame];
    [self.view addSubview:notif.view];
    [self.view bringSubviewToFront:notif.view];
    frame.origin.y = 0.0f;
    [PRTweenCGRectLerp lerp:notif.view property: @"frame" from: notif.view.frame to: frame duration:1].timingFunction = &PRTweenTimingFunctionExpoOut;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(busIncomingHandler:)
     name:@"busIncoming"
     object:nil ];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
