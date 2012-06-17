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
@synthesize itemDatas,arretDatas;
@synthesize icarousel;
@synthesize travelDetail;
@synthesize departureName;
@synthesize arrivalName;
@synthesize departureLine;
@synthesize arrivalLine;
@synthesize travelName;
@synthesize departureBtn;
@synthesize arrivalBtn;

- (void)awakeFromNib
{
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *obj in [USave getArrayForJsonPath:self.title])
    {
        NSNumber *done = [NSNumber numberWithBool:NO];
        if([[obj objectForKey:@"done"] boolValue]){
            done = [NSNumber numberWithBool:YES];
        }
        NSString *desc = [NSString stringWithFormat:@"%@ - %@ (Ligne %@)",[obj objectForKey:@"departure"],[obj objectForKey:@"arrival"],[obj objectForKey:@"line"]];
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                              [[NSArray alloc] initWithObjects:[obj objectForKey:@"title"],[obj objectForKey:@"departure"],[obj objectForKey:@"arrival"],[obj objectForKey:@"line"], desc, done,nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"title", @"departure",@"arrival",@"line",@"description", @"done", nil]]
                      forKey:[obj objectForKey:@"id"]];
        
        //[USave saveItemId:[obj objectForKey:@"id"] forType:self.title];
        //[USave saveValue:[NSNumber numberWithBool:YES] forItemId:[obj objectForKey:@"id"] forCategory:self.title]; // save mission
    }
    self.arretDatas = [[NSMutableDictionary alloc] init];
    for (NSDictionary *obj in [USave getArrayForJsonPath:@"lignes"])
    {
        NSMutableArray *arrets = [[NSMutableArray alloc] init];
        for (NSDictionary *val in [obj objectForKey:@"arrets"])
        {
            [arrets addObject:val];
        }
        [arretDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                               [[NSArray alloc] initWithObjects:[obj objectForKey:@"id"],arrets,nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"id", @"items",nil]]
                      forKey:[obj objectForKey:@"id"]];
        //NSLog(@"THE TITLE %@",[obj objectForKey:@"title"]);
    }
    
    currentLine = 0;
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
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if(index == carousel.currentItemIndex){
        
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:carousel.currentItemView cache:YES];
        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:travelDetail cache:YES];
        NSMutableDictionary *datas = [itemDatas objectForKey:[NSString stringWithFormat:@"%d",index]];
        [travelName setText:[datas valueForKey:@"title"]];
        [travelName setFont:[UIFont fontWithName:@"Kohicle25" size:travelName.font.pointSize]];
        int line = [[datas valueForKey:@"line"] intValue] + 1;
        [departureLine setText:[NSString stringWithFormat:@"Ligne %d",line]];
        [arrivalLine setText:[NSString stringWithFormat:@"Ligne %d",line]];
        [departureName setText:[datas valueForKey:@"departure"]];
        [arrivalName setText:[datas valueForKey:@"arrival"]];
        [travelDetail setHidden:NO];
        
        /*[travelDetail removeFromSuperview];
        CGRect frame = carousel.currentItemView.frame;
        frame.size = travelDetail.frame.size;
        [carousel.currentItemView addSubview:self.travelDetail];
        [travelDetail setFrame:frame];*/
    } else {
    }
    [UIView commitAnimations];
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
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *val = @"";
    if(component == 0){
        currentLine = row;
        [pickerView reloadComponent:1];
    }
    
    val = [[[arretDatas valueForKey:[NSString stringWithFormat:@"%d",currentLine]] objectForKey:@"items"] objectAtIndex:row];
    
    if(currentEditedObject == departureBtn){
        [departureName setText:[val lowercaseString]];
    }else if (currentEditedObject == arrivalBtn) {
        [arrivalName setText:[val lowercaseString]];
    }
    
    int ligne = [[[arretDatas objectForKey:[NSString stringWithFormat:@"%d",currentLine]] valueForKey:@"id"] intValue];
    val = [NSString stringWithFormat:@"Ligne %d",ligne+1];
    if(currentEditedObject == departureBtn){
        [departureLine setText:val];
    }else if (currentEditedObject == arrivalBtn) {
        [arrivalLine setText:val];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if(component == 0){
        return arretDatas.count;
    }else {
        return [[[arretDatas objectForKey:[NSString stringWithFormat:@"%d",currentLine]] objectForKey:@"items"] count];        
    }
    //return arretDatas.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    NSString *val = @"";
    if(component == 0){
        int ligne = [[[arretDatas objectForKey:[NSString stringWithFormat:@"%d",row]] valueForKey:@"id"] intValue];
        val = [NSString stringWithFormat:@"Ligne %d",ligne+1];
    }else {
        val = [[[arretDatas valueForKey:[NSString stringWithFormat:@"%d",currentLine]] objectForKey:@"items"] objectAtIndex:row];
    }
    return val;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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
    [travelDetail setHidden:YES];
    travelName.delegate = self;
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"ok"]];
    closeButton.momentary = YES; 
    closeButton.frame = CGRectMake(410.0f, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [actionSheet showInView:[self.navigationController view]];
    [actionSheet setBounds:CGRectMake(0, 0, 480, 480)];
    [actionSheet addSubview:uiPickerView];
    [actionSheet dismissWithClickedButtonIndex:0 animated:NO];
}


- (void)viewDidUnload
{
    [self setUiPickerView:nil];
    [self setTravelDetail:nil];
    [self setDepartureName:nil];
    [self setArrivalName:nil];
    [self setDepartureLine:nil];
    [self setArrivalLine:nil];
    [self setDepartureBtn:nil];
    [self setArrivalBtn:nil];
    [self setTravelName:nil];
    actionSheet = nil;
    [super viewDidUnload];
}

- (IBAction)showPickerView:(id)sender {
    currentEditedObject = sender;
    [actionSheet showInView:[self.navigationController view]];
    [actionSheet setBounds:CGRectMake(0, 0, 480, 480)];

    NSMutableDictionary *itemData = [itemDatas objectForKey:[NSString stringWithFormat:@"%d",icarousel.currentItemIndex]];
    NSMutableDictionary *arretData = [arretDatas objectForKey:[NSString stringWithFormat:@"%d",icarousel.currentItemIndex]];
    int i = 0;
    for (NSString *s in [arretData objectForKey:@"items"]) {
        if(currentEditedObject == departureBtn){
            if([[s lowercaseString] isEqualToString:[departureName.text lowercaseString]])
                break;
        }else if (currentEditedObject == arrivalBtn) {
            if([[s lowercaseString] isEqualToString:[arrivalName.text lowercaseString]])
                break;
        }
        i++;
    }
    NSLog(@"%d",i);
    [uiPickerView selectRow:[[itemData valueForKey:@"line"] intValue] inComponent:0 animated:YES];
    [uiPickerView selectRow:i inComponent:1 animated:YES];
    [uiPickerView reloadAllComponents];
}
- (IBAction)dismissActionSheet:(id)sender {
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    [actionSheet removeFromSuperview];
}
@end
