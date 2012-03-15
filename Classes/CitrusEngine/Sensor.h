//
//  Sensor.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 15/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "PhysicsObject.h"

@interface Sensor : PhysicsObject

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject;
- (void) simpleInit;

- (void) collisionStart;
- (void) collisionEnd;

@end
