//
//  TravelUIViewController.m
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TravelUIViewController.h"
#import "UImage.h"
#import "SBJsonParser.h"
#import "USave.h"
#import "TravelItemViewController.h"

@implementation TravelUIViewController
@synthesize uiPickerView;
@synthesize itemDatas;
@synthesize icarousel;

- (void)awakeFromNib
{
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *obj in [USave getArrayForJsonPath:self.title])
    {
        NSNumber *done = [NSNumber numberWithBool:NO];
        if([[obj objectForKey:@"done"] boolValue]){
            done = [NSNumber numberWithBool:YES];
        }
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                              [[NSArray alloc] initWithObjects:[obj objectForKey:@"title"], [obj objectForKey:@"description"], done,nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"title", @"description", @"done", nil]]
                      forKey:[obj objectForKey:@"id"]];
        
        //[USave saveItemId:[obj objectForKey:@"id"] forType:self.title];
        //[USave saveValue:[NSNumber numberWithBool:YES] forItemId:[obj objectForKey:@"id"] forCategory:self.title]; // save mission
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    // now add animation
   /* [UIView beginAnimations:@"View Flip" context:nil];
     [UIView setAnimationDuration:0.5];
     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
     if(index == carousel.currentItemIndex){
     
     [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight 
     forView:carousel.currentItemView cache:YES];
     
     [travelDetail removeFromSuperview];
     [carousel.currentItemView addSubview:self.productDetail];
     [travelDetail setHidden:NO];
     [travelDetail setFrame:carousel.currentItemView.frame];
     } else {
     }
     [UIView commitAnimations];*/
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 100.0;
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [itemDatas count];
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{    
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[NSString stringWithFormat:@"%d", index]];
    //create new view if no view is available for recycling
    if (view == nil)
    {
        TravelItemViewController *viewController =[[TravelItemViewController alloc] initWithNibName:@"TravelItemViewController" bundle:nil];
        [currentItem setValue:viewController forKey:@"controller"];
        view = viewController.view;
        
        [viewController.titleLabel setText:[(NSString *)[currentItem valueForKey:@"title"] uppercaseString]];
        [viewController.descLabel setText:[currentItem valueForKey:@"description"]];
        
        if(![[currentItem valueForKey:@"done"] boolValue])
            [viewController displayDone];
        
        view.layer.doubleSided = NO; //prevent back side of view from showing
    }
    
    return view;
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

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return @"Row Name";
}


#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    icarousel.type = iCarouselTypeLinear;
    icarousel.vertical = YES;
    //icarousel.viewpointOffset = CGSizeMake(0, 70);
}


- (void)viewDidUnload
{
    [self setUiPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
