//
//  InitiationViewController.m
//  ChipmunkWrapper
//
//  Created by Mac on 13/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "InitiationViewController.h"
#import "USave.h"

@implementation InitiationViewController
@synthesize titleLabel;
@synthesize icarousel,itemDatas;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)awakeFromNib
{
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *obj in [USave getArrayForJsonPath:self.title])
    {
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                              [[NSArray alloc] initWithObjects:[obj objectForKey:@"title"], [obj objectForKey:@"image-url"],nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"title", @"path", nil]]
                      forKey:[obj objectForKey:@"id"]];
    }
}


#pragma mark -
#pragma mark iCarousel methods
- (CGFloat)carousel:(iCarousel *)carousel valueForTransformOption:(iCarouselTranformOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselTranformOptionArc:
        {
            return 2 * M_PI * 0.4;
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
-(void) carouselCurrentItemIndexUpdated:(iCarousel *)carousel{
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[NSString stringWithFormat:@"%d",carousel.currentItemIndex]];
    titleLabel.text = [currentItem valueForKey:@"title"];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [itemDatas count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{    
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[NSString stringWithFormat:@"%d",carousel.currentItemIndex]];
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        view.layer.doubleSided = NO; //prevent back side of view from showing
    }
    
    return view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //configure carousel
    icarousel.type = iCarouselTypeRotary;
    icarousel.bounceDistance = 0.5;
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[NSString stringWithFormat:@"%d",icarousel.currentItemIndex]];
    titleLabel.text = [currentItem valueForKey:@"title"];    
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    icarousel.delegate = nil;
    icarousel.dataSource = nil;
    
    icarousel = nil;
    [itemDatas removeAllObjects];
    itemDatas = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
