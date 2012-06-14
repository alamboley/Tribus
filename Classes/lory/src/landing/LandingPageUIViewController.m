//
//  LandingPageUIViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 14/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "LandingPageUIViewController.h"
#import "UIImage+Sprite.h"
#import "Sparrow.h"
#import "AnimationSequence.h"
@interface LandingPageUIViewController ()

@end

@implementation LandingPageUIViewController
@synthesize uiImageView;
@synthesize sparrowView;

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
    /*[SPStage setSupportHighResolutions:YES];
    
    sparrowView.stage = [[SPStage alloc] initWithWidth:480 height:320];;
    sparrowView.frameRate = SPARROW_FRAMERATE_ACTIVE;
    [sparrowView start];
    
    AnimationSequence *loading = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"loader2.xml"] andAnimations:[NSArray arrayWithObject:@"loader"] andFirstAnimation:@"loader"];
    loading.x = 0;
    loading.y = 180;
    [sparrowView.stage addChild:loading];*/
    UIImage *spriteSheet = [UIImage imageNamed:@"loader@2x.png"];
    
    NSArray *arrayWithSprites = [spriteSheet spritesWithSpriteSheetImage:spriteSheet 
                                                              spriteSize:CGSizeMake(124, 124)];
    [uiImageView setAnimationImages:arrayWithSprites];
    float animationDuration = [uiImageView.animationImages count] * 0.03; // 100ms per frame
    
    [uiImageView setAnimationRepeatCount:0];
    [uiImageView setAnimationDuration:animationDuration]; 
    [uiImageView startAnimating];

    //[sparrowView addSubview:imgLoading];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSparrowView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
