//
//  TravelItemViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 09/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "TravelItemViewController.h"

@interface TravelItemViewController ()

@end

@implementation TravelItemViewController
@synthesize titleLabel;
@synthesize descLabel;
@synthesize okImage;
@synthesize bgImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)displayDone
{
    [bgImage setImage:[UIImage imageNamed:@"travel-item-selected.png"]];
    [okImage setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setDescLabel:nil];
    [self setOkImage:nil];
    [self setBgImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
@end
