//
//  ShopItemUIController.m
//  Tribus
//
//  Created by lbineau on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShopItemUIController.h"
#import "ColorManager.h"
#import "USave.h"

@implementation ShopItemUIController
@synthesize priceLabel;
@synthesize priceImage;
@synthesize step1UIView;
@synthesize step2UIView;
@synthesize step3UIView;
@synthesize titleLabel;
@synthesize imageView;
@synthesize descLabel;
@synthesize motifImage;
@synthesize buyButton;
@synthesize colors,colorsId,itemId,bought;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [self switchStep:step];
}
- (void) switchStep:(int)theStep{
    switch (theStep) {
        case 0:
            [step2UIView setHidden:YES];
            [step3UIView setHidden:YES];
            step++;
            break;
        case 1:
            [step1UIView setHidden:YES];
            [step2UIView setHidden:NO];
            step++;
            break;
        case 2:
            if([ColorManager removePoints:[priceLabel.text intValue] forColorId:colorsId]){
                [step2UIView setHidden:YES];
                [step3UIView setHidden:NO];
                
                [USave saveValue:[NSNumber numberWithBool:YES] forItemId:itemId forCategory:self.title];
                [USave saveValue:[NSNumber numberWithBool:YES] forItemId:itemId forCategory:[self.title stringByAppendingString:@"-inventory"]];
                step++;
            }
            else {
                step = 1;
                [step2UIView setHidden:YES];
                [step1UIView setHidden:NO];
            }
            break;
        case 3:
            [step1UIView setHidden:YES];
            [step2UIView setHidden:YES];
            [step3UIView setHidden:NO];
            break;
            
        default:
            break;
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[titleLabel setFont:[UIFont fontWithName:@"Kohicle25" size:35]];
    //[descLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:15]];
    //[buyButton.titleLabel setFont:[UIFont fontWithName:@"TwCenMT-Regular" size:13]];

    if([bought boolValue]){
        step = 3;
        [self switchStep:step];
    }
    else {
        step = 0;
        [self switchStep:step];      
    }

    for (id key in colors)
    {
        colorsId = key;
        
        NSNumber *value = [colors valueForKey:key];
        [[self priceImage] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"store_pigment_%@.png",key]]];
        [[self priceLabel] setText:[NSString stringWithFormat:@"%@ x",[value stringValue]]];
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
    [self setStep1UIView:nil];
    [self setStep2UIView:nil];
    [self setStep3UIView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
