//
//  TravelUIViewController.h
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"
#import "iCarousel.h"

@interface TravelUIViewController : GenericUIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *uiPickerView;
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@property (weak, nonatomic) IBOutlet iCarousel *icarousel;
@property (weak, nonatomic) IBOutlet UIView *travelDetail;
@end
