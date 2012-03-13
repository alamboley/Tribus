//
//  CitrusEngine.m
//  Gameline
//
//  Created by Aymeric Lamboley on 21/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CitrusEngine.h"

static int frameCount = 0;
static double timeCount = 0;

@implementation CitrusEngine

@synthesize state, aNewState;
@synthesize frameRateTextField;

static CitrusEngine *instance;

- (id)initWithWidth:(float)width height:(float)height rotation:(BOOL)rotation {
    
    if (self = [super initWithWidth:width height:height]) {
        
        instance = self;
        
        frameRateTextField = [SPTextField textFieldWithWidth:55 height:15 text:[NSString stringWithFormat:@"FPS: %.0f", 0]];
		frameRateTextField.hAlign = SPHAlignLeft;
		frameRateTextField.vAlign = SPVAlignBottom;
		frameRateTextField.color = 0xff0000;
		frameRateTextField.x = 5;
		frameRateTextField.y = 5;
		[self addChild:frameRateTextField];
        frameRateTextField.visible = FALSE;
        
        if (rotation == YES) {
            frameRateTextField.rotation = SP_D2R(90);
            frameRateTextField.x = 320;
        }
        
        [self addEventListener:@selector(step:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
	}
    
    return self;
}

+ (CitrusEngine *) getInstance {
    return instance;
}

- (void) setUpState:(State *)theNewState {
    
    aNewState = theNewState;
}

- (void)displayFrameRate:(double)passedTime {
	frameCount++;
	timeCount += passedTime;
	if (timeCount >= 1.0f) {
		frameRateTextField.text = [NSString stringWithFormat:@"FPS: %i", frameCount];
		frameCount = 0;
		timeCount -= 1.0f;
	}
}

- (void)step:(SPEnterFrameEvent *)event {
	
	[self displayFrameRate:event.passedTime];
    
    if (aNewState) {
        
        if (state) {
            // on suppr l'ancien state
        }
        
        state = aNewState;
        aNewState = nil;
        
        [self addChild:state atIndex:0];
        [state init];
    }
    
    [state update];
    
}


@end