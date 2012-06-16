//
//  GameUIViewController.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 22/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GameUIViewController.h"
#import "Main.h"


@interface GameUIViewController ()

@end

@implementation GameUIViewController
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
    self.view.autoresizingMask = sparrowView.autoresizingMask = UIViewAutoresizingNone;
    
    self.view.layer.transform = CATransform3DMakeRotation(-M_PI * 0.5, 0, 0.0, 1.0);
    
    if(startingColorId == nil) startingColorId = @"jaune";
    
    [SPStage setSupportHighResolutions:YES];
    Main *game = [[Main alloc] initWithWidth:320 height:480 rotation:YES andStartingColor:startingColorId];        
    sparrowView.stage = game;
    sparrowView.frameRate = SPARROW_FRAMERATE_ACTIVE;
    [sparrowView start];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afficherScore:) name:@"afficherScore" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changerPositionScore:) name:@"changerPositionScore" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMissionPage:) name:@"endGame" object:nil];
}

- (void) afficherScore:(NSNotification *) notification {
    
    colorUIViewController = [[ColorUIViewController alloc] initWithNibName:@"ColorUIViewController" bundle:nil andType:big];
    [self.view addSubview:colorUIViewController.view];
    colorUIViewController.view.layer.transform = CATransform3DMakeRotation(M_PI * 0.5, 0, 0.0, 1.0);
    CGFloat x = 280;
    CGFloat y = 0;
    colorUIViewController.view.frame = CGRectMake(x, y, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
}

- (void) changerPositionScore:(NSNotification *) notification {
    
    colorUIViewController.view.frame = CGRectMake(-100, -100, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
}

- (void)viewDidUnload
{
    [self setSparrowView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated];
    [colorUIViewController viewDidAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated { 
    [super viewDidDisappear:animated];
    [colorUIViewController viewDidDisappear:YES];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (void) gotoMissionPage:(NSNotification *) notification {
    [self performSegueWithIdentifier:@"PushMissionViewController" sender:self];
}

@end
