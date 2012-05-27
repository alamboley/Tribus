//
//  ColorUIViewController.m
//  Tribus
//
//  Created by lbineau on 20/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ColorUIViewController.h"
#import "Color.h"
#import "ColorManager.h"

@implementation ColorUIViewController
@synthesize bigColorView, smallColorView,currentView,textFields;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andType:(SizeType)sizeType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        type = sizeType;
    }
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandler:)
     name:@"addedPoints"
     object:nil ];
    
    [self initializeTextfields];

    return self;
}

-(void)eventHandler: (NSNotification *) notification
{
    Color *color = [[notification userInfo] valueForKey:@"color"];
    NSNumber *points = [[notification userInfo] valueForKey:@"points"];
    UILabel * tf = [textFields valueForKey:color.colorId];
    [tf setText:[color.colorValue stringValue]];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [smallColorView setHidden:YES];
    [bigColorView setHidden:YES];
    switch (type) {
        case small:
            currentView = smallColorView;
            break;
        case big:
            currentView = bigColorView;
            break;
            
        default:
            currentView = self.view;
            break;
    }
    [currentView setHidden:NO];
    //[self.view setCenter:[currentView center]];
}
- (void) initializeTextfields{
    int i = 0;
    textFields = [[NSMutableDictionary alloc] init];
    for (id key in [ColorManager getColors]) {
        Color *color = [[ColorManager getColors] objectForKey:key];
        UILabel *textField = [[UILabel alloc] initWithFrame:CGRectMake(i * 36.5 + 4, 6, 25, 25)];
        [textField setBackgroundColor:[UIColor clearColor]];
        [textField setFont:[UIFont fontWithName:@"TwCenMT-Bold" size:15]];
        textField.textColor = [Color colorWithHexString:@"0X333330"];
        textField.adjustsFontSizeToFitWidth = TRUE;
        textField.textAlignment = UITextAlignmentCenter;
        [self.view addSubview:textField]; 
        textField.text = [color.colorValue stringValue];
        [textFields setObject:textField forKey:color.colorId];
        i++;
    }
}
- (void)viewDidUnload
{
    [[self textFields] removeAllObjects];
    [self setTextFields:nil];
    [[self currentView] removeFromSuperview];
    [self setBigColorView:nil];
    [self setSmallColorView:nil];
    [self setCurrentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
