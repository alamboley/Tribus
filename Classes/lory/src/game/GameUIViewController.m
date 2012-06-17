//
//  GameUIViewController.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 22/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GameUIViewController.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@interface GameUIViewController ()

@end

@implementation GameUIViewController
@synthesize nextButton;
@synthesize sparrowView,startingColorId;

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
    
    self.view.layer.transform = CATransform3DMakeRotation(-M_PI * 0.5, 0, 0.0, 1.0);
    //self.nextButton.layer.transform = CATransform3DMakeRotation(-M_PI * 0.5, 0, 0.0, 1.0);
    
    if(startingColorId == nil) startingColorId = @"jaune";
    
    game = [[Main alloc] initWithWidth:320 height:480 rotation:YES andStartingColor:startingColorId];
    sparrowView.stage = game;
    sparrowView.frameRate = SPARROW_FRAMERATE_ACTIVE;
    [sparrowView start];
    
    self.view.autoresizingMask = sparrowView.autoresizingMask = UIViewAutoresizingNone;
    [SPStage setSupportHighResolutions:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afficherScore:) name:@"afficherScore" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changerPositionScore:) name:@"changerPositionScore" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endGame:) name:@"endGame" object:nil];
    
    [self.view bringSubviewToFront:nextButton];
    nextButton.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(90.0));
    CGRect theFrame = nextButton.frame;
    theFrame.origin.x = 5.0;
    theFrame.origin.y = 420;
    nextButton.frame = theFrame;
    [nextButton setHidden:YES];
    
    colorUIViewController = [[ColorUIViewController alloc] initWithNibName:@"ColorUIViewController" bundle:nil andType:big];
    [self.view addSubview:colorUIViewController.view];
    colorUIViewController.view.layer.transform = CATransform3DMakeRotation(M_PI * 0.5, 0, 0.0, 1.0);
    colorUIViewController.view.frame = CGRectMake(-100, -100, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
}

- (void) afficherScore:(NSNotification *) notification {
    
    colorUIViewController.view.frame = CGRectMake(280, 0, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
}

- (void) changerPositionScore:(NSNotification *) notification {
    
    colorUIViewController.view.frame = CGRectMake(-100, -100, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
}

- (void)viewDidUnload
{
    [self setSparrowView:nil];
    [self setNextButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated];
    [colorUIViewController viewDidAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated { 
    
    [game destroy];
    game = nil;
    
    [sparrowView stop];
    sparrowView = nil;
    
    [super viewDidDisappear:animated];
    [colorUIViewController viewDidDisappear:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (void) endGame:(NSNotification *) notification {
    [nextButton setHidden:NO];
}

@end
