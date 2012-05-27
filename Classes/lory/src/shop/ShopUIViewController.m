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

@implementation ShopUIViewController

@synthesize productDetail;
@synthesize icarousel;
@synthesize itemDatas;
@synthesize colorUIViewController;

- (void)awakeFromNib
{
    // Creation du parser
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"motif" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    // On récupère le JSON en NSString depuis la réponse
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // on parse la reponse JSON
    NSArray *res = [parser objectWithString:json_string error:nil];
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    for (NSDictionary *obj in res)
    {
        // on peut recuperer les valeurs en utilisant objectForKey à partir du status qui est un NSDictionary
        for (id key in [obj objectForKey:@"price"])
        {
            id value = [[obj objectForKey:@"price"] objectForKey:key];
            //NSLog(@"%@ : %@", key, value);
        }
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
         [[NSArray alloc] initWithObjects:[obj objectForKey:@"title"], [obj objectForKey:@"description"],[obj objectForKey:@"image-url"],[obj objectForKey:@"price"],nil] forKeys:
         [[NSArray alloc] initWithObjects:@"title", @"description",@"path",@"colors",nil]]
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
    
    colorUIViewController = [[ColorUIViewController alloc] initWithNibName:@"ColorUIViewController" bundle:nil andType:big];
    [self.view addSubview:colorUIViewController.view];
    
    CGFloat x = ([self view].bounds.size.height - [colorUIViewController view].bounds.size.width) / 2;
    CGFloat y = [self view].bounds.size.width  - 50;
    colorUIViewController.view.frame = CGRectMake(x, y, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);

    [[[self navigationUIViewController] pageTitle] setText:@"échoppe"];
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
        view = viewController.view;

        [viewController.titleLabel setText:[currentItem valueForKey:@"title"]];
        [viewController.descLabel setText:[currentItem valueForKey:@"description"]];
        [viewController.motifImage setImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        NSLog(@"%@",[UIImage imageNamed:[currentItem valueForKey:@"path"]]);
        //view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        view.layer.doubleSided = NO; //prevent back side of view from showing
    }
    
    return view;
}

@end
