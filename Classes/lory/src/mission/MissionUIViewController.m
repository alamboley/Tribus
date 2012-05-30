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
#import "UIImage+Sprite.h"
#import "USave.h"

@implementation MissionUIViewController
@synthesize itemDatas;
@synthesize icarousel;
@synthesize uiImageView;

- (void)awakeFromNib
{
    // Creation du parser
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"missions" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    // On récupère le JSON en NSString depuis la réponse
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // on parse la reponse JSON
    NSArray *res = [parser objectWithString:json_string error:nil];
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *obj in res)
    {
        NSNumber *done = [NSNumber numberWithBool:NO];
        if([[[USave getItemIdsforType:self.title] valueForKey:[obj objectForKey:@"id"]] boolValue]){
            done = [NSNumber numberWithBool:YES];
        }
        [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                              [[NSArray alloc] initWithObjects:[obj objectForKey:@"title"], [obj objectForKey:@"description"], done,nil] forKeys:
                              [[NSArray alloc] initWithObjects:@"title", @"description", @"done", nil]]
                      forKey:[obj objectForKey:@"id"]];
        
        //[USave saveItemId:[obj objectForKey:@"id"] forType:self.title]; // save mission
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
    UIImage *spriteSheet = [UIImage imageNamed:@"explosion_4_39_128"];

    NSArray *arrayWithSprites = [spriteSheet spritesWithSpriteSheetImage:spriteSheet 
                                                              spriteSize:CGSizeMake(128, 128)];
    [uiImageView setAnimationImages:arrayWithSprites];
    float animationDuration = [uiImageView.animationImages count] * 0.010; // 100ms per frame
    
    [uiImageView setAnimationRepeatCount:0];
    [uiImageView setAnimationDuration:animationDuration]; 
    [uiImageView startAnimating];
    
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
    [self setUiImageView:nil];
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
