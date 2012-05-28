//
//  ChipmunkAppDelegate.m
//  Chipmunk
//
//  Created by Ronald Mathies on 12/27/10.
//  Copyright Sodeso 2010. All rights reserved.
//

#import "ChipmunkAppDelegate.h"
#import "Main.h" 

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

void onUncaughtException(NSException *exception) {
	NSLog(@"uncaught exception: %@", exception.description);
}

// --- private interface ---------------------------------------------------------------------------

@interface ChipmunkAppDelegate ()

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation ChipmunkAppDelegate

@synthesize window;
@synthesize sparrowView;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    //SP_CREATE_POOL(pool);    
    
	[application setStatusBarHidden:YES];
    [SPStage setSupportHighResolutions:YES];
	
	// Exception handler, when exceptions occure you can put a
	// breakpoint on line 15 to see the stacktrace as to
	// where the exception occured
	NSSetUncaughtExceptionHandler(&onUncaughtException);
	
    Main *game = [[Main alloc] initWithWidth:320 height:480 rotation:YES];
    sparrowView.stage = game;
    sparrowView.frameRate = SPARROW_FRAMERATE_ACTIVE;
    [sparrowView start];
    [window makeKeyAndVisible];
    
	// No audio needed.
	//[SPAudioEngine start];
	
    //SP_RELEASE_POOL(pool);
}

- (void)applicationWillResignActive:(UIApplication *)application {
	[sparrowView stop];
	sparrowView.frameRate = SPARROW_FRAMERATE_INACTIVE;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	if(![sparrowView isStarted]) {
		sparrowView.frameRate = SPARROW_FRAMERATE_ACTIVE;
		[sparrowView start];
	}
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [SPPoint purgePool];
    [SPRectangle purgePool];
    [SPMatrix purgePool];    
}

- (void)dealloc {
	// No audio needed.
	[SPAudioEngine stop];
}

@end
