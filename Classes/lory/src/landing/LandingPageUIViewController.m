//
//  LandingPageUIViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 14/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "LandingPageUIViewController.h"
#import "UIImage+Sprite.h"
@interface LandingPageUIViewController ()

@end

@implementation LandingPageUIViewController
@synthesize uiImageView;

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
    UIImage *spriteSheet = [UIImage imageNamed:@"loader-.png"];
    
    NSArray *arrayWithSprites = [spriteSheet spritesWithSpriteSheetImage:spriteSheet 
                                                              spriteSize:CGSizeMake(60, 60)];
    [uiImageView setAnimationImages:arrayWithSprites];
    float animationDuration = [uiImageView.animationImages count] * 0.1; // 100ms per frame
    
    [uiImageView setAnimationRepeatCount:0];
    [uiImageView setAnimationDuration:animationDuration]; 
    [uiImageView startAnimating];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
