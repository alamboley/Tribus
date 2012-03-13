//
//  State.h
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "SPSprite.h"
#import "SPDebugDraw.h"
#import "CitrusObject.h"
#import "PhysicsObject.h"

@interface State : SPSprite <UIAccelerometerDelegate> {
    
@protected
	
	id mDelegate;
    
    SPDebugDraw *debugDraw;
    
    CMSpace *space;
    
    PhysicsObject *cameraTarget;
    
    float cameraLensWidth;
    CGRect cameraBounds;
    CGPoint cameraOffset;
    CGPoint cameraEasing;
    
    BOOL inverseGravity;
    
    NSMutableArray *objects;
}

@property (nonatomic) id delegate;
@property (nonatomic) NSMutableArray *objects;

@property (nonatomic) CMSpace *space;
@property (nonatomic) PhysicsObject *cameraTarget;

- (id) init;

- (void)showHideDebugDraw;

- (void) addObject:(CitrusObject *) object;

- (void) setupCamera:(PhysicsObject *) target andOffset:(CGPoint) offset andBounds:(CGRect) bounds andEasing:(CGPoint) easing;

- (void)update;

@end