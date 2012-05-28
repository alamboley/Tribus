//
//  CreationRuntime.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 07/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CitrusEngine.h"
#import "CitrusObject.h"
#import "AnimationSequence.h"

@interface CreationRuntime : NSObject {
    
    NSTimer *timerParticle;
    NSTimer *timerPiege;
    NSTimer *timerDecor;
    NSString *world;
    
    CitrusEngine *ce;
    CitrusObject *hero;
    
    AnimationSequence *animFiltreVert;
}

- (id) initWithWorld:(NSString *) worldColor;

- (void) start;
- (void) stop;

@end
