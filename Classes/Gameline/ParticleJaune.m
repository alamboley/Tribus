//
//  ParticleJaune.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 19/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "ParticleJaune.h"
#import "CitrusEngine.h"
#import "CitrusObject.h"

@implementation ParticleJaune

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super initWithName:paramName params:params]) {
        
    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        imgFond = [SPImage imageWithContentsOfFile:@"particleFondJaune.png"];
       [self addChild:imgFond atIndex:0];
        
        imgFond.x = posX - imgFond.width / 2;
        imgFond.y = posY - imgFond.height / 2;
    }
    
    return self;
}

- (void) defineShape {
    
    [super defineShape];
    
    [shape setCollisionType:@"particleJaune"];
}

- (void) simpleInit {
    
    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"particleJaune" target:self begin:@selector(collisionStart: space:) preSolve:NULL postSolve:NULL separate:NULL];
}

- (BOOL) collisionStart:(CMArbiter*) arbiter space:(CMSpace*) space {
        
    [super collisionStart];
    
    ((CitrusObject *)arbiter.shapeB.body.data).kill = YES;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorJaune" object:nil];
    
    return YES;
}

@end
