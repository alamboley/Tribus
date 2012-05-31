//
//  EcranFumee.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "EcranFumee.h"

@implementation EcranFumee

- (id) initWithAnimationSequence:(AnimationSequence *) animationSequence {
    
    if (self = [super init]) {
        
        
        animEcranNoir = animationSequence;
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0) {
            
            animEcranNoir.scaleX = 2;
            animEcranNoir.scaleY = 2;
        }
        
        
        animEcranNoir.rotation = SP_D2R(90);
        
        animEcranNoir.x = 320;
        animEcranNoir.y = 0;
        
        [animEcranNoir changeAnimation:@"noirExplosion" withLoop:NO];
        
        [self addChild:animEcranNoir];
        
        [animEcranNoir addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    
    return self;
}

- (void) destroy {
    
    [self removeChild:animEcranNoir];
    
    [animEcranNoir removeEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void) onTouch:(SPTouchEvent *) event {
    
    SPTouch *touchPhaseMoved = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] anyObject];
    SPTouch *touchBegan = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    
    if (touchBegan && animDisparition == nil) {
        
        [animEcranNoir changeAnimation:@"noirDisparition" withLoop:NO];
        animDisparition = [animEcranNoir getCurrentAnimaiton];
        [animDisparition pause];
    }
    
    if (touchPhaseMoved) {
        
        if (!previousPointTouched)
            previousPointTouched = [touchPhaseMoved locationInSpace:self];
        
        SPPoint *touchPosition = [touchPhaseMoved locationInSpace:self];
        
        if ((touchPosition.y > previousPointTouched.y + 50) || (touchPosition.y < previousPointTouched.y - 50)) {
            [animDisparition play];
            previousPointTouched = touchPosition;
        } else {
            [animDisparition pause];
        }
        
        if (animDisparition.currentFrame + 1 == animDisparition.numFrames) {
            [self destroy];
        }
        
    }
}

@end
