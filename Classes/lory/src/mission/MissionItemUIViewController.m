//
//  MissionItemUIViewController.m
//  Tribus
//
//  Created by lbineau on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MissionItemUIViewController.h"

@implementation MissionItemUIViewController
@synthesize titleLabel;
@synthesize descLabel;
@synthesize okImage;
@synthesize okImageBg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)displayDone
{
    [okImage setHidden:YES];
    [okImageBg setHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [titleLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:20]];
    [descLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:17]];
    [okImage setHidden:NO];
    [okImageBg setHidden:NO];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setDescLabel:nil];
    [self setOkImage:nil];
    [self setOkImageBg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
@end
