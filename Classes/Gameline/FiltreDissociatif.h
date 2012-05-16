//
//  FiltreDissociatif.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 16/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Sensor.h"

@interface FiltreDissociatif : Sensor {
    
    NSString *color;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject andColor:(NSString *) worldColor;

@end
