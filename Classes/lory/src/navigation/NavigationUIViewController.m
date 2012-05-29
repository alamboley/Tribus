//
//  NavigationUIViewController.m
//  Tribus
//
//  Created by lbineau on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NavigationUIViewController.h"

@implementation NavigationUIViewController
@synthesize pageTitle;

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

- (void)setTitle:(NSString *)title
{
    //pageTitle.text = [title uppercaseString];
    pageTitle.text = title;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set title on label
    [pageTitle setFont:[UIFont fontWithName:@"Kohicle25" size:35]];
    [pageTitle setText:self.title];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPageTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
