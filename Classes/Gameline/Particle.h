//
//  Particle.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 19/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Sensor.h"
#import "CitrusObject.h"
#import "AnimationSequence.h"

@interface Particle : Sensor {
    
    SPImage *imgFond;
    CitrusObject *hero;
    NSString *worldColor;
    
    AnimationSequence *particleTaken;
}

@property BOOL prise;

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject withWorld:(NSString *)world andAnim:(AnimationSequence *) animParticleTaken;
- (void) simpleInit;

- (void) addParticlePrise;

@end
