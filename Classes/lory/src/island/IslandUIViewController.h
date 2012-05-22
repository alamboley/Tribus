//
//  IslandUIViewController.h
//  Tribus
//
//  Created by lbineau on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"
#import "NMCustomLabel.h"
#import "iCarousel.h"

@interface IslandUIViewController : GenericUIViewController<iCarouselDataSource,iCarouselDelegate>;
@property (retain, nonatomic) NMCustomLabel *islandTitle;
@property (weak, nonatomic) IBOutlet iCarousel *icarousel;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@end
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]