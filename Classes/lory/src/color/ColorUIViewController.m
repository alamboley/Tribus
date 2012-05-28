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
    
    [self initializeTextfields];

    return self;
}
-(void)notEnoughPointsHandler: (NSNotification *) notification
{
    Color *color = [[notification userInfo] valueForKey:@"color"];
    NSNumber *points = [[notification userInfo] valueForKey:@"points"];
    
    UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Achat" message: [NSString stringWithFormat:@"Il te manque : %@ pigments \"%@\" pour acheter ce motif", [points stringValue], color.label] delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [someError show];
}
-(void)changedPointsHandler: (NSNotification *) notification
{
    bool added = [notification name] == @"addedPoints";

    Color *color = [[notification userInfo] valueForKey:@"color"];
    NSNumber *points = [[notification userInfo] valueForKey:@"points"];
    UILabel * tf = [textFields valueForKey:color.colorId];
    
    // TF for tween points
    UILabel *textField = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    textField.userInteractionEnabled = NO;
    CGRect frame = [textField frame];
    frame.origin.x = tf.frame.origin.x + 5;
    frame.origin.y = -10;
    textField.frame = frame;
    textField.alpha = 0;
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setFont:[UIFont fontWithName:@"TwCenMT-Bold" size:20]];
    textField.textColor = [Color colorWithHexString:@"0XFFFFFF"];
    textField.adjustsFontSizeToFitWidth = TRUE;
    textField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:textField];
    NSString *s = added ? @"+ " : @"- ";
    s = [s stringByAppendingString:[points stringValue]];
    textField.text = s;
    [tf setText:[color.colorValue stringValue]];
    // Tween for when we add points
    
    // alpha...
    [PRTween tween:textField property:@"alpha" from:1 to:0 duration:2].completeBlock = ^{
        [textField removeFromSuperview];
    };
    [PRTween tween:tf property:@"alpha" from:0 to:1 duration:1].timingFunction = &PRTweenTimingFunctionExpoOut;;

    // ...and position of changing points TF
    frame.origin.y = -40; // end of easing
    [PRTweenCGRectLerp lerp:textField property: @"frame" from: textField.frame to: frame duration:3].timingFunction = &PRTweenTimingFunctionExpoOut;
    
    // value of actual textfield
    /*[PRTween tween:points property:@"intValue" from:[color.colorValue intValue] to:[color.colorValue intValue] - [points intValue] duration:1].updateBlock = ^(PRTweenPeriod *period){
        [tf setText:[NSString stringWithFormat: @"%d", (int)period.tweenedValue]];
    };*/
    

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
    textFields = [[NSMutableDictionary alloc] init];
    for (id key in [ColorManager getColors]) {
        Color *color = [[ColorManager getColors] objectForKey:key];
        UILabel *textField = [[UILabel alloc] initWithFrame:CGRectMake([color.order intValue] * 36.5 + 4, 6, 25, 25)];
        [textField setBackgroundColor:[UIColor clearColor]];
        [textField setFont:[UIFont fontWithName:@"TwCenMT-Bold" size:15]];
        textField.textColor = [Color colorWithHexString:@"0X333330"];
        textField.adjustsFontSizeToFitWidth = TRUE;
        textField.textAlignment = UITextAlignmentCenter;
        [self.view addSubview:textField]; 
        textField.text = [color.colorValue stringValue];
        [textFields setObject:textField forKey:color.colorId];
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
-(void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(changedPointsHandler:)
     name:@"addedPoints"
     object:nil ];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(changedPointsHandler:)
     name:@"removedPoints"
     object:nil ];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(notEnoughPointsHandler:)
     name:@"notEnoughPoints"
     object:nil ];
}

-(void)viewDidDisappear:(BOOL)animated { 
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"addedPoints"
     object:nil ];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"removedPoints"
     object:nil ];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"notEnoughPoints"
     object:nil ];
}

@end
