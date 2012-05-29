//
//  MissionItemUIViewController.h
//  Tribus
//
//  Created by lbineau on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MissionItemUIViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *okImage;
@property (weak, nonatomic) IBOutlet UIImageView *okImageBg;

- (void)displayDone;

@end
