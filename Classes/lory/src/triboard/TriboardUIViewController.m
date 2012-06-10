//
//  TriboardUIViewController.m
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TriboardUIViewController.h"
#import "USave.h"
#import "SBJsonParser.h"
#import "TriboardItemUIViewController.h"
#import "UImage.h"

@implementation TriboardUIViewController
@synthesize itemsContainer;
@synthesize gestureOutlet;
@synthesize itemDatas;
@synthesize colorUIViewController;

- (id)init {
	if (self = [super init]) {
        
	}
	return self;
}
- (void)awakeFromNib
{

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

    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(itemFromBagUsed:) 
                                                 name:@"itemFromBagUsed" 
                                               object:nil];
    colorUIViewController = [[ColorUIViewController alloc] initWithNibName:@"ColorUIViewController" bundle:nil andType:big];
    [self.view addSubview:colorUIViewController.view];
    CGFloat x = ([self view].bounds.size.height - [colorUIViewController view].bounds.size.width) / 2;
    CGFloat y = [self view].bounds.size.width  - 50;
    colorUIViewController.view.frame = CGRectMake(x, y, colorUIViewController.view.frame.size.width, colorUIViewController.view.frame.size.height);
    
    // Creation du parser
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"triboard" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    // On récupère le JSON en NSString depuis la réponse
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // on parse la reponse JSON
    NSArray *res = [parser objectWithString:json_string error:nil];
    
    self.itemDatas = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *obj in res)
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
    //NSLog(@"index %@", self.tabBarController.selectedIndex);
    int i = 0;
    /*for (NSDictionary *obj in itemDatas)
    {
        NSLog(@"dafuq %@",obj);
        /*TriboardItemUIViewController *item = [obj objectForKey:@"item"];
        if(item.button == sender){
            break;
        }*/
        /*i++;
    }*/
    [[NSNotificationCenter defaultCenter] postNotificationName:@"itemSelectedFromTriboard" 
     object:[NSNumber numberWithInt:[[((UIButton*)sender).titleLabel text] intValue]]];
    self.tabBarController.selectedIndex = 1;
}

- (void)itemFromBagUsed:(NSNotification *)notification {
    NSObject *foo;
    foo = [notification object];
    NSLog(@"Object received : %@",foo);
    //do something else
}
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
    [self setGestureOutlet:nil];
    [self setItemsContainer:nil];
    [self setColorUIViewController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
