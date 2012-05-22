//
//  GenericUIViewController.h
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "NavigationUIViewController.h"

@interface GenericUIViewController : UIViewController{
    NavigationUIViewController *navigationUIViewController;
    UIView *viewBackButton;
}
@property (weak, nonatomic) IBOutlet UILabel *viewTitleLabel;
@property (nonatomic,retain) NavigationUIViewController *navigationUIViewController;
@end
