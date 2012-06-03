//
//  TriboardUIViewController.h
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"

@interface TriboardUIViewController : GenericUIViewController
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *gestureOutlet;
-(IBAction)busIncoming:(UIGestureRecognizer *)sender;
@end
