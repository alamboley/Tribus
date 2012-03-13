//
//  State.m
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "State.h"

// --- Static variables ----------------------------------------------------------------------------

// --- Static inline methods -----------------------------------------------------------------------

// --- private interface ---------------------------------------------------------------------------

@interface State ()

- (BOOL)disableAccelerometer;
- (BOOL)disableWindowContainment;
- (BOOL)disableDefaultTouchHandler;

@end

// --- Class implementation ------------------------------------------------------------------------

@implementation State

@synthesize delegate = mDelegate;
@synthesize objects;
@synthesize space;
@synthesize cameraTarget;

- (id) init {
    
	if (self = [super init]) {
		
		if (![self disableDefaultTouchHandler]) {
			//[self addEventListener:@selector(force:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
		}
		
		if (![self disableAccelerometer]) {
			UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
			accelerometer.updateInterval = 1.0f/30.0f;
			accelerometer.delegate = self;
		}
        
        objects = [[NSMutableArray alloc] init];
        
        inverseGravity = NO;
		
        // Setup the chipmunk space.
        space = [[CMSpace alloc] init];
        [space setSleepTimeThreshhold:5.0f];
        [space setIterations:25];
        [space setGravity:cpv(0, 150)];
        
        // When applicable add the window containment. -> ajout des bordures à l'écran
        /*if (![self disableWindowContainment]) {
         [mSpace addWindowContainmentWithWidth:480 height:320 elasticity:0.0 friction:1.0];
         }*/
		
		debugDraw = [[SPDebugDraw alloc] initWithManager:space];
		[self addChild:debugDraw];
        [debugDraw setVisible:FALSE];
        [debugDraw setTouchable:FALSE];
        
        cameraLensWidth = 480;
	}
    
	return self;
}

- (void) addObject:(CitrusObject *) object {
    
    [objects addObject:object];
    
    if (object.graphic) {
        [self addChild:object];
        object.x = object.y = 0;
        
        //if ([debugDraw visible])
          //  [self swapChild:debugDraw withChild:object];
    }
}

- (void)showHideDebugDraw {
    
	[debugDraw setVisible:![debugDraw visible]];
}

- (BOOL)disableAccelerometer {
	return NO;
}

- (BOOL)disableWindowContainment {
	return NO;
}

- (BOOL)disableDefaultTouchHandler {
	return NO;
}

- (void) setupCamera:(PhysicsObject *) target andOffset:(CGPoint) offset andBounds:(CGRect) bounds andEasing:(CGPoint) easing {
    
    cameraTarget = target;
    cameraOffset = offset;
    cameraBounds = bounds;
    cameraEasing = easing;
}

- (void) update {
    
    [space step:1.0f / 15.0f];
	[space updateShapes];

    for (CitrusObject *object in objects) {
        [object update];
    }
    
    if (cameraTarget) {

        float diffX = (-cameraTarget.body.position.x + cameraOffset.x) - self.y;
        float velocityX = diffX * cameraEasing.x;
        self.y += velocityX;
        
        if (-self.y <= cameraBounds.origin.x || cameraBounds.size.width < cameraLensWidth) {
            self.y = -cameraBounds.origin.x;
        } else if (-self.y + cameraLensWidth >= cameraBounds.size.width) {
            self.y = -cameraBounds.size.width + cameraLensWidth;
        }
    }
    
}

- (void) dealloc {
    
	UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
	accelerometer.delegate = nil;

    
    
    
	
}

@end