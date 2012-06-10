//
//  FiltreAssociatif.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 10/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Sensor.h"

@interface FiltreAssociatif : Sensor {
    
    NSString *color;
    
    CitrusObject *hero;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject andColor:(NSString *) worldColor;

@end