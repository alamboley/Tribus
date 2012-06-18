//
//  MissionAfterUIViewController.h
//  ChipmunkWrapper
//
//  Created by Mac on 18/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GenericUIViewController.h"

@interface MissionAfterUIViewController : GenericUIViewController
@property (weak, nonatomic) IBOutlet UIImageView *bonusView;
- (IBAction)displayBonus:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonView;

@end
