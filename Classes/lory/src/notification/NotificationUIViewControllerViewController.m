//
//  NotificationUIViewControllerViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 01/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "NotificationUIViewControllerViewController.h"

@interface NotificationUIViewControllerViewController ()

@end

@implementation NotificationUIViewControllerViewController
@synthesize busButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self setBusButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)busIsComing:(id)sender {
    [self.view setHidden:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startGame" object:nil];
}
@end
