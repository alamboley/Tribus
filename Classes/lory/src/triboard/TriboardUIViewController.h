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
@property (weak, nonatomic) IBOutlet UIView *itemsContainer;
@property (weak, nonatomic) IBOutlet UIView *motifsContainer;
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@property (nonatomic, retain) NSString *itemIdSelected;
@property (weak, nonatomic) IBOutlet UIImageView *motifMilieu;
@property (weak, nonatomic) IBOutlet UIButton *pouvoirBtn;
- (IBAction)itemSelected:(id)sender;
@end
