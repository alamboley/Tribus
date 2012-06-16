//
//  GameUIViewController.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 22/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorUIViewController.h"
#import "Main.h"

@interface GameUIViewController : UIViewController {
    
    Main *game;
    
    ColorUIViewController *colorUIViewController;
}
@property (weak, nonatomic) IBOutlet SPView *sparrowView;
@property (nonatomic, retain) NSString *startingColorId;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
