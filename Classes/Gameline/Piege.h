//
//  Piege.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 20/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Sensor.h"

@interface Piege : Sensor {
    
    CitrusObject *hero;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject;
- (void) simpleInit;

@end
