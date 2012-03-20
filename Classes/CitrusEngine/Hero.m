//
//  Hero.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 05/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Hero.h"
#import "CitrusEngine.h"
#import "AnimationSequence.h"

@implementation Hero

@synthesize velocityX, velocityY;

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super initWithName:paramName params:params]) {
        
        [self simpleInit];
    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        [self simpleInit];
    }
    
    return self;
}

- (void) defineShape {
    
    [super defineShape];
    
    [shape setCollisionType:@"hero"];
}

- (void) simpleInit {
    
    [body setMoment:INFINITY];
    
    self.velocityX = 50;
    
    [ce.state addEventListener:@selector(touched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    //[super.space addCollisionHandlerBetween:@"hero" andTypeB:@"platform" target:self begin:@selector(collisionAmoi) preSolve:NULL postSolve:NULL separate:NULL];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeAnimation) userInfo:nil repeats:NO];
}

- (void) touched:(SPTouchEvent *) event {
    
    SPTouch *begin = [[event touchesWithTarget:ce.state andPhase:SPTouchPhaseBegan] anyObject];
    
    if (begin) {
        touchScreen = TRUE;

    }
    
    SPTouch *end = [[event touchesWithTarget:ce.state andPhase:SPTouchPhaseEnded] anyObject];
    
    if (end) {
        touchScreen = FALSE;
    }
    
}

- (void) changeAnimation {
    
    if ([graphic isKindOfClass:[AnimationSequence class]]) {
        [(AnimationSequence *)graphic changeAnimation:@"walk" withLoop:YES];
    }
}

- (void) update {
    
    [super update];
    
    cpVect velocity = [body velocity];
    
    velocity.x = velocityX;
    
    if (touchScreen) {
        
        if (velocity.y > -150)
            velocity.y -= 20;
        
    }
    [body setVelocity:velocity];
}

@end
