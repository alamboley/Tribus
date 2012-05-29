//
//  GenericUIViewController.m
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"

@implementation GenericUIViewController
@synthesize viewTitleLabel;
@synthesize navigationUIViewController;

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

// BACK BUTTON

- (IBAction)goBackInStack:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}
/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navigationUIViewController =[[NavigationUIViewController alloc] initWithNibName:@"NavigationUIViewController" bundle:nil];
    [self addChildViewController:navigationUIViewController];
    [[self view] addSubview:navigationUIViewController.view];
    [navigationUIViewController setTitle:[self title]];
}
- (void)viewDidUnload
{
    [navigationUIViewController removeFromParentViewController];
    [[navigationUIViewController view] removeFromSuperview];
    [self setNavigationUIViewController:nil];
    [self setViewTitleLabel:nil];
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
