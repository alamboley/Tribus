//
//  FondParallax.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 01/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CitrusObject.h"

@interface FondParallax : CitrusObject {
    
    CitrusObject *hero;
    
    int index;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andWorld:(NSString *)world;

@end
