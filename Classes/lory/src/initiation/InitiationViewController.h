//
//  InitiationViewController.h
//  ChipmunkWrapper
//
//  Created by Mac on 13/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GenericUIViewController.h"
#import "iCarousel.h"

@interface InitiationViewController : GenericUIViewController<iCarouselDataSource,iCarouselDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet iCarousel *icarousel;
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@end