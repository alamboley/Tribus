//
//  TravelUIViewController.m
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TravelUIViewController.h"

@implementation TravelUIViewController
@synthesize uiPickerView;

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
#pragma mark -
#pragma mark picker view methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%d", row);
    [self image: [UIImage imageNamed:@"back-btn.png"] WithTint: [UIColor colorWithWhite:1.0 alpha:1.0]];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return @"Row Name";
}
// Tint the image
- (void)image:(UIImage*)image WithTint:(UIColor *)tintColor {
        
    UIImageView *originalImageView = [[UIImageView alloc] initWithImage:image];
    [originalImageView setFrame:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height)];
    [self.view addSubview:originalImageView];
    
    UIView *overlay = [[UIView alloc] initWithFrame:[originalImageView frame]];
    
    UIImageView *maskImageView = [[UIImageView alloc] initWithImage:image];
    [maskImageView setFrame:[overlay bounds]];
    
    [[overlay layer] setMask:[maskImageView layer]];
    
    [overlay setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:overlay];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setUiPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
