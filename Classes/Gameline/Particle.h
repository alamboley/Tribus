//
//  Particle.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 19/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Sensor.h"
#import "CitrusObject.h"

@interface Particle : Sensor {
    
    SPImage *imgFond;
    CitrusObject *hero;
    NSString *worldColor;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject withWorld:(NSString *)world;
- (void) simpleInit;

@end
