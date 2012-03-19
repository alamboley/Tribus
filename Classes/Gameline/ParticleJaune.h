//
//  ParticleJaune.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 19/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Particle.h"

@interface ParticleJaune : Particle

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject;
- (void) simpleInit;

@end
