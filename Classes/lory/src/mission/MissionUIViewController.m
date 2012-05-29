//
//  MissionUIViewController.m
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MissionUIViewController.h"
#import "SBJsonParser.h"
#import "MissionItemUIViewController.h"

@implementation MissionUIViewController
@synthesize itemDatas;
@synthesize icarousel;

- (void)awakeFromNib
{
    // Creation du parser
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"mission" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    // On récupère le JSON en NSString depuis la réponse
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // on parse la reponse JSON
    NSArray *res = [parser objectWithString:json_string error:nil];
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *obj in res)
    {
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                              [[NSArray alloc] initWithObjects:[obj objectForKey:@"title"], [obj objectForKey:@"description"], [obj objectForKey:@"done"],nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"title", @"description", @"done", nil]]
                      forKey:[obj objectForKey:@"id"]];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    icarousel.type = iCarouselTypeLinear;
    icarousel.vertical = YES;
    icarousel.viewpointOffset = CGSizeMake(0, 70);
}


- (void)viewDidUnload
{
    //free up memory by releasing subviews
    icarousel.delegate = nil;
    icarousel.dataSource = nil;
    
    icarousel = nil;
    [itemDatas removeAllObjects];
    itemDatas = nil;
    
    [self setIcarousel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 70.0;
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
        MissionItemUIViewController *viewController =[[MissionItemUIViewController alloc] initWithNibName:@"MissionItemUIViewController" bundle:nil];
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
@end
