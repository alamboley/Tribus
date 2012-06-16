#import "TriboardItemUIViewController.h"

@implementation TriboardItemUIViewController
@synthesize button;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [button setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:0.9 alpha:0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.3 green:0.6 blue:0.9 alpha:0] forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
