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
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject;
- (void) simpleInit;

@end
