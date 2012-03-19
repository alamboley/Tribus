//
//  ParticleJaune.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 19/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "ParticleJaune.h"

@implementation ParticleJaune

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super initWithName:paramName params:params]) {
        
    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
    }
    
    return self;
}

- (void) defineShape {
    
    [super defineShape];
    
    [shape setCollisionType:@"particleJaune"];
}


- (void) simpleInit {
    
    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"particleJaune" target:self begin:@selector(collisionStart) preSolve:NULL postSolve:NULL separate:NULL];
}

- (void) collisionStart {
    
    [super collisionStart];
    
    NSLog(@"particleJauneTouched");
}

@end
