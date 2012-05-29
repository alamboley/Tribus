//
//  ShopItemUIController.m
//  Tribus
//
//  Created by lbineau on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShopItemUIController.h"
#import "ColorManager.h"

@implementation ShopItemUIController
@synthesize priceLabel;
@synthesize priceImage;
@synthesize titleLabel;
@synthesize imageView;
@synthesize descLabel;
@synthesize motifImage;
@synthesize buyButton;
@synthesize colors,colorsId;

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
    if(clicked){
        NSLog(@"bought");
        [ColorManager removePoints:[priceLabel.text intValue] forColorId:colorsId];
        clicked = NO;        
    }
    else{
        [[self priceImage] setHidden:NO];
        [[self priceLabel] setHidden:NO];
        [[self buyButton] setTitle:@"" forState:UIControlStateNormal];
        clicked = YES;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleLabel setFont:[UIFont fontWithName:@"Kohicle25" size:35]];
    [descLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:15]];
    [buyButton.titleLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:13]];
    clicked = NO;
    [[self priceImage] setHidden:YES];
    [[self priceLabel] setHidden:YES];
    for (id key in colors)
    {
        colorsId = key;
        NSNumber *value = [colors valueForKey:key];
        [[self priceLabel] setText:[[value stringValue] stringByAppendingString:key]];
    }
    //NSLog(@"%@ : ", colors);
    [priceLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:15]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setTitleLabel:nil];
    [self setDescLabel:nil];
    [self setMotifImage:nil];
    [self setBuyButton:nil];
    [self setPriceLabel:nil];
    [self setPriceImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
