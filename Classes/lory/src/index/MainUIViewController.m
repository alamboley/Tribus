//
//  MainUIViewController.m
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainUIViewController.h"
#import "PRTween.h"
#import "ColorManager.h"
#import "LandingPageUIViewController.h"
#import "USave.h"

@implementation MainUIViewController
@synthesize notifMissions;
@synthesize nextBusUILabel;
@synthesize colorUIViewController;

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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //UIButton *button = (UIButton *)sender;
    //UIViewController *vc = [segue destinationViewController];
    //vc.title = button.titleLabel.text;
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
    
    colorUIViewController = [[ColorUIViewController alloc] initWithNibName:@"ColorUIViewController" bundle:nil andType:big];
    [self.view addSubview:colorUIViewController.view];
    
    CGFloat x = ([self view].bounds.size.height - [colorUIViewController view].bounds.size.width) / 2;
    CGFloat y = [self view].bounds.size.width  - 50;
    colorUIViewController.view.frame = CGRectMake(x, y, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
    // toast with duration, title, and position
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(startGameHandler:)
     name:@"startGame"
     object:nil];
    
    minutesLeft = 5;
    
    //LandingPageUIViewController *landing = [[LandingPageUIViewController alloc] initWithNibName:@"LandingPageUIViewController" bundle:nil];
    
    //[self.view addSubview:landing.view];

    /*LandingPageUIViewController *landing = [[LandingPageUIViewController alloc] initWithNibName:@"LandingPageUIViewController" bundle:nil];
    
    [self.view addSubview:landing.view];*/
    if ([USave getItemIdsforType:@"main"] != nil && [[USave getItemIdsforType:@"main"] objectForKey:@"notifmission"] != nil) {
        [notifMissions setHidden:YES];
            } else {                
                [USave saveValue:[NSNumber numberWithBool:YES] forItemId:@"notifmission" forCategory:@"main"];
                    }

}
-(void)startGameHandler: (NSNotification *) notification{
    [self performSegueWithIdentifier:@"island" sender:self];    
}

- (void)viewDidUnload
{
    [colorUIViewController.view removeFromSuperview];
    [self setColorUIViewController:nil];
    notif = nil;
    [self setNextBusUILabel:nil];
    [self setNotifMissions:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated];
    [colorUIViewController viewDidAppear:YES];
    [nextBusUILabel setText:[NSString stringWithFormat:@"Prochain bus dans : %d min" , minutesLeft >1 ? minutesLeft-- : 1]];
}

-(void)viewDidDisappear:(BOOL)animated { 
    [super viewDidDisappear:animated];
    [colorUIViewController viewDidDisappear:YES];
    [notifMissions setHidden:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
@end
