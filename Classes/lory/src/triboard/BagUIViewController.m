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
#import "SBJsonParser.h"
#import "UImage.h"

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
    // Creation du parser
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:self.title ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    // On récupère le JSON en NSString depuis la réponse
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // on parse la reponse JSON
    NSArray *res = [parser objectWithString:json_string error:nil];
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *obj in res)
    {
        // on peut recuperer les valeurs en utilisant objectForKey à partir du status qui est un NSDictionary
        for (id key in [obj objectForKey:@"items"])
        {
            //id value = [[obj objectForKey:@"items"] objectForKey:key];
        }
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                              [[NSArray alloc] initWithObjects:[obj objectForKey:@"id"],[obj objectForKey:@"title"],[obj objectForKey:@"image-url"],[obj objectForKey:@"items"],nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"id", @"title",@"path",@"items",nil]]
                      forKey:[obj objectForKey:@"id"]];
        
        /*[[NSNotificationCenter defaultCenter] postNotificationName:@"itemFromBagUsed" 
         object:[[NSObject alloc] init]];*/
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
    colorUIViewController = [[ColorUIViewController alloc] initWithNibName:@"ColorUIViewController" bundle:nil andType:big];
    [self.view addSubview:colorUIViewController.view];
    CGFloat x = ([self view].bounds.size.height - [colorUIViewController view].bounds.size.width) / 2;
    CGFloat y = [self view].bounds.size.width  - 50;
    colorUIViewController.view.frame = CGRectMake(x, y, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
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
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[NSString stringWithFormat:@"%d", carousel.currentItemIndex]];
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
        [currentItem setValue:viewController forKey:@"controller"];
        //viewController.colors = [currentItem objectForKey:@"colors"];
        //viewController.itemId = [currentItem valueForKey:@"id"];
        //viewController.bought = [[USave getItemIdsforType:self.title] valueForKey:viewController.itemId];
        
        view = viewController.view;
        
        //[viewController.titleLabel setText:[currentItem valueForKey:@"title"]];
        //[viewController.descLabel setText:[currentItem valueForKey:@"description"]];
        //[viewController.motifImage setImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        viewController.title = self.title;
        
        //NSLog(@"Items for page : %@ %@", self.title,[USave getItemIdsforType:self.title]);
        
        //view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        view.layer.doubleSided = NO; //prevent back side of view from showing
    }
    
    return view;
}

#pragma mark - View lifecycle
-(void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated];
    [colorUIViewController viewDidAppear:YES];
}

-(void)viewDidDisappear:(BOOL)animated { 
    [super viewDidDisappear:animated];
    [colorUIViewController viewDidDisappear:YES];
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
    self.tabBarController.selectedIndex = 0;
}
@end
