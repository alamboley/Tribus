//
//  EcranFumee.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "SPSprite.h"
#import "AnimationSequence.h"

@interface EcranFumee : SPSprite {
    
    AnimationSequence *animEcranNoir;
    
    SPMovieClip *animDisparition;
    SPPoint *previousPointTouched;
}

- (id) initWithAnimationSequence:(AnimationSequence *) animationSequence;

- (void) destroy;

@end
