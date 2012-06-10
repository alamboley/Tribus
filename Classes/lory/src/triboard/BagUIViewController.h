//
//  BagUIViewController.h
//  Tribus
//
//  Created by lbineau on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenericUIViewController.h"
#import "ColorUIViewController.h"
#import "iCarousel.h"

@interface BagUIViewController : GenericUIViewController{
    int currentIndex;
}
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@property (nonatomic, retain) ColorUIViewController *colorUIViewController;
@property (weak, nonatomic) IBOutlet iCarousel *icarousel;

@end
