//
//  TravelItemViewController.h
//  ChipmunkWrapper
//
//  Created by Mac on 09/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelItemViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *okImage;
- (void)displayDone;

@end
