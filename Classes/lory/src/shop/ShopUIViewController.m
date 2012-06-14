//
//  IslandUIViewController.m
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShopUIViewController.h"
#import "SBJson.h"
#import "ShopItemUIController.h"
#import "ColorManager.h"
#import "USave.h"
#import "Toast+UIView.h"

@implementation ShopUIViewController

@synthesize productDetail;
@synthesize icarousel;
@synthesize itemDatas;
@synthesize colorUIViewController;

- (void)awakeFromNib
{
    self.itemDatas = [[NSMutableDictionary alloc] init];

    for (NSDictionary *obj in [USave getArrayForJsonPath:self.title])
    {
        for (id key in [obj objectForKey:@"price"])
        {
            id value = [[obj objectForKey:@"price"] objectForKey:key];
            //NSLog(@"%@ : %@", key, value);
        }
        NSString *level = [obj objectForKey:@"level"] != nil ? [obj objectForKey:@"level"] : @"none";
        
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
         [[NSArray alloc] initWithObjects:[obj objectForKey:@"id"],[obj objectForKey:@"title"],level, [obj objectForKey:@"description"],[obj objectForKey:@"image-url"],[obj objectForKey:@"price"],nil] forKeys:
         [[NSArray alloc] initWithObjects:@"id", @"title", @"level", @"description",@"path",@"colors",nil]]
         forKey:[obj objectForKey:@"id"]];
    }

}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    icarousel.type = iCarouselTypeRotary;
    icarousel.bounceDistance = 0.2;

    
    colorUIViewController = [[ColorUIViewController alloc] initWithNibName:@"ColorUIViewController" bundle:nil andType:big];
    [self.view addSubview:colorUIViewController.view];
    
    CGFloat x = ([self view].bounds.size.height - [colorUIViewController view].bounds.size.width) / 2;
    CGFloat y = [self view].bounds.size.width  - 50;
    colorUIViewController.view.frame = CGRectMake(x, y, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);

    [[[self navigationUIViewController] pageTitle] setText:@"échoppe"];
    /*[self.view makeToast:@"This is a piece of toast" 
                duration:3.0
                position:@"top right"
                   title:@"Toast Title"];*/
}

- (void)viewDidUnload
{    
    //free up memory by releasing subviews
    icarousel.delegate = nil;
    icarousel.dataSource = nil;
    
    icarousel = nil;
    [itemDatas removeAllObjects];
    itemDatas = nil;
    
    [self setColorUIViewController:nil];
    
    [self setProductDetail:nil];
    [super viewDidUnload];
}
-(void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated];
    [colorUIViewController viewDidAppear:YES];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(notEnoughPointsHandler:)
     name:@"notEnoughPoints"
     object:nil ];
}

-(void)viewDidDisappear:(BOOL)animated { 
    [super viewDidDisappear:animated];
    [colorUIViewController viewDidDisappear:YES];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"notEnoughPoints"
     object:nil ];
}
-(void)notEnoughPointsHandler: (NSNotification *) notification
{
    Color *color = [[notification userInfo] valueForKey:@"color"];
    NSNumber *points = [[notification userInfo] valueForKey:@"points"];
    
    UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Achat" message: [NSString stringWithFormat:@"Il te manque : %@ pigments \"%@\" pour l'acheter", [points stringValue], color.label] delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [someError show];
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
- (BOOL)carouselShouldWrap:(iCarousel *)carousel{
    return NO;
}
- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel{
    
    //[productDetail removeFromSuperview];
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
        viewController.title = self.title;
        [currentItem setValue:viewController forKey:@"controller"];
        viewController.colors = [currentItem objectForKey:@"colors"];
        viewController.itemId = [currentItem valueForKey:@"id"];
        viewController.level = [currentItem valueForKey:@"level"];
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

@end
