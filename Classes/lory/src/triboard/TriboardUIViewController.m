//
//  TriboardUIViewController.m
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TriboardUIViewController.h"
#import "USave.h"
#import "TriboardItemUIViewController.h"
#import "UImage.h"

@implementation TriboardUIViewController
@synthesize itemsContainer,itemIdSelected;
@synthesize gestureOutlet;
@synthesize motifsContainer;
@synthesize itemDatas;
@synthesize motifMilieu;

- (id)init {
	if (self = [super init]) {
        
	}
	return self;
}
-(void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(itemSelectedFromBag:) 
                                                 name:@"itemSelectedFromBag" 
                                               object:nil];
}
-(IBAction)busIncoming:(UIGestureRecognizer *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"busIncoming" object:nil];    
}
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
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    int i = 0;
    for (NSDictionary *obj in [USave getArrayForJsonPath:@"triboard"])
    {
        TriboardItemUIViewController *item = [[TriboardItemUIViewController alloc] initWithNibName:@"TriboardItemUIViewController" bundle:nil];
        
        NSInteger i = [(NSString*)[obj objectForKey:@"id"]integerValue];
        [self.itemDatas setObject:[[NSMutableDictionary alloc] initWithObjects:
                                   [[NSArray alloc] initWithObjects:[obj objectForKey:@"id"],[obj objectForKey:@"title"],item,nil] forKeys:
                                   [[NSArray alloc] initWithObjects:@"id", @"title", @"item", nil]]
                           forKey:[obj objectForKey:@"id"]];
        
        UIImageView *view = [[itemsContainer subviews] objectAtIndex:i];
        
        //NSLog(@"%@",(NSString *)[obj objectForKey:@"itemId"]);

        /*UIView *coloredView = [[UImage alloc] image: view.image WithTint: [UIColor colorWithWhite:1.0 alpha:1.0]];*/
        
        //coloredView.frame.origin = CGPointMake(0.0f, 0.0f);
        [itemsContainer addSubview:item.view];
        item.view.frame = view.frame;
        
        [item.button setTitle:(NSString*)[obj objectForKey:@"id"] forState:UIControlStateNormal];
        if((NSString *)[obj objectForKey:@"itemId"] == @"none"){
            [item.button setImage:[UIImage imageNamed:@"store_pigment_none@2x.png"] forState:UIControlStateNormal];
        }else {
            [item.button setImage:[UIImage imageNamed:@"store_pigment_none@2x.png"] forState:UIControlStateNormal];
        }
        [item.button addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    for (NSDictionary *obj in [USave getItemIdsforType:@"inventory"])
    {
        NSLog(@"Inventory item : %@",obj);
    }
}

- (IBAction)itemSelected:(id)sender {
/*    [[NSNotificationCenter defaultCenter] postNotificationName:@"itemSelectedFromTriboard" 
     object:[NSNumber numberWithInt:[[((UIButton*)sender).titleLabel text] intValue]]];*/
    for (NSString *obj in self.itemDatas) {
        NSDictionary *item = [self.itemDatas valueForKey:obj];
        TriboardItemUIViewController *vc = [item valueForKey:@"item"];

        if(vc.button == sender){
            itemIdSelected = obj;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"itemSelectedFromTriboard" 
                                                        object:[NSNumber numberWithInt:0]];
    self.tabBarController.selectedIndex = 1;
}

- (void)itemSelectedFromBag:(NSNotification *)notification {
    NSObject *foo;
    foo = [notification object];
    UIImageView *view;
    TriboardItemUIViewController *vc = [[itemDatas valueForKey:itemIdSelected] valueForKey:@"item"];
    for (NSDictionary *obj in [USave getArrayForJsonPath:@"motifs"]){
        if([[NSString stringWithFormat:@"%@",foo] isEqualToString:[obj valueForKey:@"id"]]){
            [vc.button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"store_pigment_%@@2x.png",[obj valueForKey:@"color"]]] forState:UIControlStateNormal];
            view = [[motifsContainer subviews] objectAtIndex:[itemIdSelected intValue]];
            [view setImage:[UIImage imageNamed:[NSString stringWithFormat:@"triboard-item-%@.png",[obj valueForKey:@"id"]]]];
        }
    }
}
-(void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated { 
    [super viewDidDisappear:animated];
}
- (void)viewDidUnload
{
    [self setGestureOutlet:nil];
    [self setItemsContainer:nil];
    [self setMotifMilieu:nil];
    [self setMotifsContainer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
