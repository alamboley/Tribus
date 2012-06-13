//
//  BagScrollItemUIViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 13/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "BagScrollItemUIViewController.h"

@interface BagScrollItemUIViewController ()

@end

@implementation BagScrollItemUIViewController
@synthesize titleLabel;
@synthesize descLabel;
@synthesize powerImage;
@synthesize backgroundImage;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDescLabel:nil];
    [self setTitleLabel:nil];
    [self setPowerImage:nil];
    [self setBackgroundImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
