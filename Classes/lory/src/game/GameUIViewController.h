//
//  GameUIViewController.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 22/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorUIViewController.h"

@interface GameUIViewController : UIViewController {
    
    ColorUIViewController *colorUIViewController;
}
@property (weak, nonatomic) IBOutlet SPView *sparrowView;

@end
