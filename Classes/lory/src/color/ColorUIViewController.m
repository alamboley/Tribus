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
@synthesize bigColorView, smallColorView,currentView;

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
    NSLog(@"event triggered");
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
    for (id key in [ColorManager getColors]) {
        Color *color = [[ColorManager getColors] objectForKey:key];
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(i * 47 - 13, 15, 77, 77)];
        [textField setFont:[UIFont fontWithName:@"TwCenMT-Bold" size:20]];
        textField.returnKeyType = UIReturnKeyDone;
        textField.placeholder = @"NA";
        textField.textColor = [[UIColor alloc] initWithWhite:1 alpha:1];
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.adjustsFontSizeToFitWidth = TRUE;
        textField.textAlignment = UITextAlignmentCenter;
        [textField addTarget:self 
                      action:@selector(textFieldDone:) 
            forControlEvents:UIControlEventEditingDidEndOnExit];     
        [self.view addSubview:textField]; 
        textField.text = [color.colorValue stringValue];
        i++;
    }
}
- (void)viewDidUnload
{
    [self setBigColorView:nil];
    [self setSmallColorView:nil];
    [self setCurrentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
