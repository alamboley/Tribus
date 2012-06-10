//
//  BagUIViewController.m
//  Tribus
//
//  Created by lbineau on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BagUIViewController.h"
#import "USave.h"
#import "SBJsonParser.h"
#import "UImage.h"

@implementation BagUIViewController
@synthesize itemDatas;
@synthesize colorUIViewController;
@synthesize icarousel;

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
    //configure carousel
    icarousel.type = iCarouselTypeRotary;
    icarousel.bounceDistance = 0.5;

    /*[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(itemFromBagUsed:) 
                                                 name:@"itemFromBagUsed" 
                                               object:nil];*/
    colorUIViewController = [[ColorUIViewController alloc] initWithNibName:@"ColorUIViewController" bundle:nil andType:big];
    [self.view addSubview:colorUIViewController.view];
    CGFloat x = ([self view].bounds.size.height - [colorUIViewController view].bounds.size.width) / 2;
    CGFloat y = [self view].bounds.size.width  - 50;
    colorUIViewController.view.frame = CGRectMake(x, y, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
    
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
            NSLog(@"Item id : %@", key);
        }
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                              [[NSArray alloc] initWithObjects:[obj objectForKey:@"id"],[obj objectForKey:@"title"],[obj objectForKey:@"image-url"],[obj objectForKey:@"items"],nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"id", @"title",@"path",@"items",nil]]
                      forKey:[obj objectForKey:@"id"]];
        
        /*[[NSNotificationCenter defaultCenter] postNotificationName:@"itemFromBagUsed" 
                                                            object:[[NSObject alloc] init]];*/
    }
}
- (BOOL)carouselShouldWrap:(iCarousel *)carousel{
    return NO;
}
- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel{
    
    //[productDetail removeFromSuperview];
}
- (void)carouselDidScroll:(iCarousel *)carousel{
    
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[NSString stringWithFormat:@"%d", carousel.currentItemIndex]];
    
}
-(CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 250.0;
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [itemDatas count];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    // now add animation
    /*[UIView beginAnimations:@"View Flip" context:nil];
     [UIView setAnimationDuration:0.5];
     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
     if(index == carousel.currentItemIndex){
     
     [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight 
     forView:carousel.currentItemView cache:YES];
     
     [productDetail removeFromSuperview];
     [carousel.currentItemView addSubview:self.productDetail];
     [productDetail setHidden:NO];
     [productDetail setFrame:carousel.currentItemView.frame];
     } else {
     }
     [UIView commitAnimations];*/
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{    
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[NSString stringWithFormat:@"%d", index]];
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        ShopItemUIController *viewController =[[ShopItemUIController alloc] initWithNibName:@"ShopItemUIController" bundle:nil];
        [currentItem setValue:viewController forKey:@"controller"];
        viewController.colors = [currentItem objectForKey:@"colors"];
        viewController.itemId = [currentItem valueForKey:@"id"];
        viewController.bought = [[USave getItemIdsforType:self.title] valueForKey:viewController.itemId];
        
        view = viewController.view;
        
        [viewController.titleLabel setText:[currentItem valueForKey:@"title"]];
        [viewController.descLabel setText:[currentItem valueForKey:@"description"]];
        [viewController.motifImage setImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        viewController.title = self.title;
        
        //NSLog(@"Items for page : %@ %@", self.title,[USave getItemIdsforType:self.title]);
        
        //view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        view.layer.doubleSided = NO; //prevent back side of view from showing
    }
    
    return view;
}
#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [self setIcarousel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
