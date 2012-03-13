//
//  ChipmunkAppDelegate.h
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright Sodeso 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sparrow.h" 

// --- Types ---------------------------------------------------------------------------------------

// --- Interface ---------------------------------------------------------------------------------------

@interface ChipmunkAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    SPView *sparrowView;
}

@property (nonatomic) IBOutlet UIWindow *window;
@property (nonatomic) IBOutlet SPView *sparrowView;

@end
