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

@implementation TriboardUIViewController
@synthesize gestureOutlet;

- (id)init {
	if (self = [super init]) {
        
	}
	return self;
}
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

    for (NSDictionary *obj in [USave getItemIdsforType:@"inventory"])
    {
        NSLog(@"Inventory item : %@",obj);
    }
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
}
- (void)itemFromBagUsed:(NSNotification *)notification {
    NSObject *foo;
    foo = [notification object];
    NSLog(@"Object received : %@",foo);
    //do something else
}

- (void)viewDidUnload
{
    [self setGestureOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
