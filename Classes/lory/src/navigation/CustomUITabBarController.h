//
//  CustomUITabBarController.h
//  Tribus
//
//  Created by lbineau on 05/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorUIViewController.h"
@interface CustomUITabBarController : UITabBarController <UITabBarControllerDelegate>
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) ColorUIViewController *colorUIViewController;

@end