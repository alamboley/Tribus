//
//  BagUIViewController.m
//  Tribus
//
//  Created by lbineau on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BagUIViewController.h"
#import "BagItemUIViewController.h"
#import "USave.h"
#import "UImage.h"
#import "USave.h"

@implementation BagUIViewController
@synthesize itemDatas;
@synthesize colorUIViewController;
@synthesize icarousel;
@synthesize okButton;

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

#pragma mark - View lifecycle

- (void)awakeFromNib
{
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *obj in [USave getArrayForJsonPath:self.title])
    {
        for (id key in [obj objectForKey:@"items"])
        {
            //[USave saveValue:[NSNumber numberWithBool:YES] forItemId:(NSString*)obj forCategory:[obj objectForKey:@"title"]];
            [USave saveValue:[NSNumber numberWithBool:YES] forItemId:(NSString*)key forCategory:[[obj objectForKey:@"title"] stringByAppendingString:@"-inventory"]];
            //id value = [[obj objectForKey:@"items"] objectForKey:key];
            NSLog(@"key %@",key);
        }
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                              [[NSArray alloc] initWithObjects:[obj objectForKey:@"id"],[obj objectForKey:@"title"],[obj objectForKey:@"image-url"],[obj objectForKey:@"items"],nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"id", @"title",@"path",@"items",nil]]
                      forKey:[obj objectForKey:@"id"]];
        //NSLog(@"THE TITLE %@",[obj objectForKey:@"title"]);
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(itemSelectedFromTriboard:) 
                                                 name:@"itemSelectedFromTriboard" 
                                               object:nil];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //configure carousel
    icarousel.type = iCarouselTypeRotary;
    icarousel.viewpointOffset = CGSizeMake(-10, -70);
    icarousel.bounceDistance = 0.5;
    icarousel.currentItemIndex = currentIndex;
}
- (void)itemSelectedFromTriboard:(NSNotification *)notification {
    NSLog(@"%@",notification.object);
    currentIndex = [(NSNumber *)notification.object intValue];
    [icarousel scrollToItemAtIndex: currentIndex animated:YES];
}
#pragma mark -
#pragma mark iCarousel methods
- (CGFloat)carousel:(iCarousel *)carousel valueForTransformOption:(iCarouselTranformOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselTranformOptionArc:
        {
            return 2 * M_PI * 0.5;
        }
        case iCarouselTranformOptionRadius:
        {
            return value * 1;
        }
        default:
        {
            return value;
        }
    }
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if(index == carousel.currentItemIndex){
        [okButton setHidden:NO];
    }
}
- (BOOL)carouselShouldWrap:(iCarousel *)carousel{
    return NO;
}
- (void)carouselDidScroll:(iCarousel *)carousel{
    [okButton setHidden:YES];
}
-(CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 250.0;
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
        BagItemUIViewController *viewController =[[BagItemUIViewController alloc] initWithNibName:@"BagItemUIViewController" bundle:nil];
        viewController.title = [currentItem valueForKey:@"title"];
        [currentItem setValue:viewController forKey:@"controller"];
        //viewController.colors = [currentItem objectForKey:@"colors"];
        //viewController.itemId = [currentItem valueForKey:@"id"];
        //viewController.bought = [[USave getItemIdsforType:self.title] valueForKey:viewController.itemId];
        
        view = viewController.view;
        
        //[viewController.titleLabel setText:[currentItem valueForKey:@"title"]];
        //[viewController.descLabel setText:[currentItem valueForKey:@"description"]];
        //[viewController.motifImage setImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        
        //NSLog(@"Items for page : %@ %@", self.title,[USave getItemIdsforType:self.title]);
        
        //view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        view.layer.doubleSided = NO; //prevent back side of view from showing
    }
    
    return view;
}

#pragma mark - View lifecycle
-(void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated { 
    [super viewDidDisappear:animated];
}
- (void)viewDidUnload
{
    icarousel.delegate = nil;
    icarousel.dataSource = nil;
    
    icarousel = nil;
    [itemDatas removeAllObjects];
    itemDatas = nil;
    [self setOkButton:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"itemSelectedFromTriboard" object:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)itemForTriboardSelected:(id)sender {
    /*[[NSNotificationCenter defaultCenter] postNotificationName:@"itemSelectedFromBag" 
                                                        object:[NSNumber numberWithInt:1]];*/
    self.tabBarController.selectedIndex = 0;
}
@end
