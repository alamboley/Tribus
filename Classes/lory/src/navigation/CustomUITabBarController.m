//
//  CustomUITabBarController.m
//  Tribus
//
//  Created by lbineau on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomUITabBarController.h"
#import "Color.h"

@implementation CustomUITabBarController

@synthesize buttons;

#pragma mark - View lifecycle
- (id) init
{
    self = [super init];
    if (self) 
    {
        self.delegate = self;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    buttons = [NSMutableArray arrayWithObjects:nil];
    
    // Remove the tabBar
    [self.tabBar setHidden:YES];
    [self.tabBar removeFromSuperview];
    UIView *contentView;
    if ([[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        contentView = [self.view.subviews objectAtIndex:1];
    } else {
        contentView = [self.view.subviews objectAtIndex:0];
    }
    contentView.frame = self.view.bounds;
    self.selectedIndex = 0;
    // Add the same number of buttons as in the tabBar
    for( int i = 0; i < [self.viewControllers count]; i++ ) {
        UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];

        UIViewController *item = [self.viewControllers objectAtIndex:i];
        UIImage *buttonImageNormal;
        UIImage *buttonImageSelected;
        
        if([item.title isEqualToString:@"coupons"]){
            buttonImageNormal = [UIImage imageNamed:@"coupons-button-selected.png"];
            buttonImageSelected = [UIImage imageNamed:@"coupons-button-normal.png"];
            [aButton setTitleColor:[Color colorWithHexString: @"5C461E"] forState:UIControlStateNormal];
        }else {
            buttonImageNormal = [UIImage imageNamed:@"main-button-normal.png"];
            buttonImageSelected = [UIImage imageNamed:@"main-button-selected.png"];
            [aButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        aButton.frame = CGRectMake(5 + i * 110.0, 5.0, buttonImageNormal.size.width,buttonImageNormal.size.height);
        
        aButton.titleLabel.font = [UIFont fontWithName:@"TwCenMT-Regular" size:17];
        [aButton setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
        [aButton setBackgroundImage:buttonImageSelected forState:UIControlStateSelected];
        [aButton setTitle:[item.title uppercaseString] forState:UIControlStateNormal];
        [aButton setTag:i];
        [aButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [aButton setContentEdgeInsets:UIEdgeInsetsMake(0, -4, 0, 0)];
        [self.view addSubview:aButton];
        
        int controllerIndex = (int)[aButton tag];
        if(controllerIndex == self.selectedIndex){
            [aButton setSelected:YES];
        }
        
        [buttons addObject:aButton];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)buttonClicked:(UIButton*)button
{
    [self setSelectedIndex:(int)[button tag]];
}

-(void)setSelectedIndex:(NSUInteger)index{
    [super setSelectedIndex:index];
    [self updateButtons:index];
}
-(void)updateButtons:(NSUInteger)index{
    // Get views. controllerIndex is passed in as the controller we want to go to. 
    // Get the views.
    for( int i = 0; i < [self.buttons count]; i++ ) {
        UIButton* aButton = [self.buttons objectAtIndex:i];
        [aButton setSelected:NO];
        if(index == (int)[aButton tag])
            [aButton setSelected:YES];
    }
    if(index != self.selectedIndex){
        //Transition
        [UIView beginAnimations:@"animation" context:nil];
        //[myNavigationController pushViewController:myViewController animated:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.navigationController.view cache:NO];
        [UIView setAnimationDuration:0.5];
        [UIView commitAnimations];
        //self.selectedIndex = index;
        [self.navigationItem setTitle: self.title];
    }
}

- (void)viewDidUnload
{
    [buttons removeAllObjects];
    [self setButtons:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
@end
