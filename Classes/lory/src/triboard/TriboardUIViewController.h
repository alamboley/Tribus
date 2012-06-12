//
//  TriboardUIViewController.h
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"
#import "ColorUIViewController.h"

@interface TriboardUIViewController : GenericUIViewController
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *gestureOutlet;
-(IBAction)busIncoming:(UIGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIView *itemsContainer;
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@property (nonatomic, retain) ColorUIViewController *colorUIViewController;
@property (weak, nonatomic) IBOutlet UIImageView *motifMilieu;

@end
