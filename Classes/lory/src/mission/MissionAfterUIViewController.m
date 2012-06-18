//
//  MissionAfterUIViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 18/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "MissionAfterUIViewController.h"

@interface MissionAfterUIViewController ()

@end

@implementation MissionAfterUIViewController
@synthesize buttonView;
@synthesize bonusView;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setBonusView:nil];
    [self setButtonView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)displayBonus:(id)sender {
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
    
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:buttonView cache:YES];
    [buttonView setHidden:YES];
    
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
    
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:bonusView cache:YES];
    [bonusView setHidden:NO];
    
    [UIView commitAnimations];
}
@end
