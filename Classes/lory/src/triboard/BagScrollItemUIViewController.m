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
@synthesize motifImage;
@synthesize titleLabel;
@synthesize descLabel;
@synthesize powerImage;
@synthesize backgroundImage;
@synthesize imagePath,desc,type,backgroundPath;

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
    [titleLabel setText:self.title];
    [descLabel setText:self.desc];
    
    if([self.type isEqualToString:@"pouvoirs"]){
        backgroundPath = @"inventaire_fondpouvoir2.png";
        powerImage.image = [UIImage imageNamed:imagePath];
    }else{
        backgroundPath = @"inventaire_fondboard.png";
        motifImage.image = [UIImage imageNamed:imagePath];
    }
    
    backgroundImage.image = [UIImage imageNamed:backgroundPath];
}

- (void)viewDidUnload
{
    [self setDescLabel:nil];
    [self setTitleLabel:nil];
    [self setPowerImage:nil];
    [self setBackgroundImage:nil];
    [self setMotifImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
