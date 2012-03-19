//
//  Sensor.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 15/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Sensor.h"

@implementation Sensor

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {

    if (self = [super initWithName:paramName params:params]) {
        
        [self simpleInit];
    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject {

    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        [self simpleInit];
    }
    
    return self;
}

- (void) createBody {
    
    body = [space addStaticBody];
}

- (void) defineShape {
    
    [super defineShape];
    
    [shape setSensor:YES];
    [shape setCollisionType:@"sensor"];
}

- (void) simpleInit {
    
     [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"sensor" target:self begin:@selector(collisionStart) preSolve:NULL postSolve:NULL separate:@selector(collisionEnd)];
}

- (void) collisionStart {
    
    
    NSLog(@"pok");
}

- (void) collisionEnd {
    
    NSLog(@"ook");
}

@end
