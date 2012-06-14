//
//  IslandUIViewController.m
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IslandUIViewController.h"
#import "Color.h"
#import "GameUIViewController.h"

@implementation IslandUIViewController

@synthesize islandTitle;
@synthesize icarousel;
@synthesize items;
@synthesize itemDatas;

- (void)awakeFromNib
{
    self.items = [NSMutableArray arrayWithObjects:
                  @"red",
                  @"green",
                  @"orange",
                  @"yellow",
                  @"blue",
                  @"purple",
                  nil];
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:[[Color alloc]  initWithId:@"rouge" andCode:@"0xAD2304" andLabel:@"Rouge"], @"ile_rouge.png",@"<b>Tneera</b>, l'île fumante",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:0]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:[[Color alloc] initWithId:@"vert" andCode:@"0x445132" andLabel:@"Verte"], @"ile_verte.png",@"<b>Hilja</b>, l'île dansante",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:1]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:[[Color alloc]  initWithId:@"orange" andCode:@"0xA8510C" andLabel:@"Orange"], @"ile_orange.png",@"<b>Oren</b>, l'île dormante",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:2]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:[[Color alloc]  initWithId:@"jaune" andCode:@"0x8D5D2E" andLabel:@"Jaune"], @"ile_jaune.png",@"<b>Isfar</b>, l'île sablonneuse",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:3]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:[[Color alloc]  initWithId:@"bleu" andCode:@"0x3B4444" andLabel:@"Bleu"], @"ile_bleue.png",@"<b>Pancada</b>, l'île cristaline",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:4]];
    
    [itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                          [[NSArray alloc] initWithObjects:[[Color alloc]  initWithId:@"violet" andCode:@"0x582E97" andLabel:@"Violet"], @"ile_violette.png",@"<b>Bahlû</b>, l'île sombre",nil] forKeys:
                          [[NSArray alloc] initWithObjects:@"color", @"path",@"title",nil]]
                  forKey:[items objectAtIndex:5]];
}
-(IBAction)gotoGame:(id)sender{
    if(currentColorId == @"jaune" || currentColorId == @"rouge"){
        [self performSegueWithIdentifier:@"PushGameViewController" sender:sender];
    }else{
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Attention" message: [NSString stringWithFormat:@"Cette île sera bientôt disponible"] delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [someError show];        
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GameUIViewController *vc = [segue destinationViewController];
    vc.startingColorId = currentColorId;
    //vc.title = button.titleLabel.text;
}
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    icarousel.type = iCarouselTypeRotary;
    icarousel.viewpointOffset = CGSizeMake(0, -10);
    CGFloat width = [UIScreen mainScreen].bounds.size.height;
    CGFloat height = [UIScreen mainScreen].bounds.size.width;
    islandTitle = [[NMCustomLabel alloc] initWithFrame:CGRectMake(0, height - 50, width, 100)];
    islandTitle.ctTextAlignment = kCTCenterTextAlignment;
    [islandTitle setBackgroundColor:[UIColor clearColor]];
    islandTitle.font = [UIFont fontWithName:@"Kohicle25" size:25];
    islandTitle.fontBold = [UIFont fontWithName:@"Kohicle25" size:40];
    [self.view addSubview:islandTitle];
    
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[items objectAtIndex:icarousel.currentItemIndex]];
    islandTitle.text = [currentItem valueForKey:@"title"];
    islandTitle.textColor = [(Color *)[currentItem valueForKey:@"color"] color];
    currentColorId = [(Color *)[currentItem valueForKey:@"color"] colorId];
    
    [navigationUIViewController setTitle:@""];
    [navigationUIViewController.backButton setHidden:YES];
    //[viewBackButton setHidden:YES];
}

- (void)viewDidUnload
{
    [self setIslandTitle:nil];
    
    //free up memory by releasing subviews
    icarousel.delegate = nil;
    icarousel.dataSource = nil;
    
    icarousel = nil;
    [items removeAllObjects];
    items = nil;
    [itemDatas removeAllObjects];
    itemDatas = nil;
    
    currentColorId = nil;
    
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
            return 2 * M_PI * 1;
        }
        case iCarouselTranformOptionRadius:
        {
            return value * 1.5;
        }
        default:
        {
            return value;
        }
    }
}
-(void) carouselCurrentItemIndexUpdated:(iCarousel *)carousel{
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[items objectAtIndex:carousel.currentItemIndex]];
    islandTitle.text = [currentItem valueForKey:@"title"];
    islandTitle.textColor = [(Color *)[currentItem valueForKey:@"color"] color];
    currentColorId = [(Color *)[currentItem valueForKey:@"color"] colorId];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if(index == carousel.currentItemIndex){
        if(currentColorId == @"jaune" || currentColorId == @"rouge"){
            [self performSegueWithIdentifier:@"PushGameViewController" sender:self];
        }else{
            UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Attention" message: [NSString stringWithFormat:@"Cette île sera bientôt disponible"] delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [someError show];        
        }
    }
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{    
    NSMutableDictionary *currentItem = [itemDatas objectForKey:[items objectAtIndex:index]];
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[currentItem valueForKey:@"path"]]];
        view.layer.doubleSided = NO; //prevent back side of view from showing
    }
    
    return view;
}

@end
