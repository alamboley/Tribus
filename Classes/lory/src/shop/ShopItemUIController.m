//
//  ShopItemUIController.m
//  Tribus
//
//  Created by lbineau on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShopItemUIController.h"

@implementation ShopItemUIController
@synthesize titleLabel;
@synthesize imageView;
@synthesize descLabel;
@synthesize motifImage;
@synthesize buyButton;

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

- (IBAction)buyAction:(id)sender {
    NSLog(@"BUY");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleLabel setFont:[UIFont fontWithName:@"Kohicle25" size:35]];
    [descLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:15]];
    [buyButton.titleLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:13]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setTitleLabel:nil];
    [self setDescLabel:nil];
    [self setMotifImage:nil];
    [self setBuyButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
