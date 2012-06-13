//
//  TaedioAspire.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 31/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "TaedioAspire.h"
#import "CitrusEngine.h"
#import "AnimationSequence.h"
#import "Hero.h"

@implementation TaedioAspire

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

- (void) destroy {
    
    [body removeShape:sensorDetectionHero];
    
    [super destroy];
}

- (void) update {
    
    [super update];
    
    if (!hero) {
        
        hero = [ce.state getObjectByName:@"hero"];
        
    } else {
        
        if (hero.x - hero.width > body.position.x) {
            
            self.kill = YES;
        }
    }
}

- (void) createShape {
    
    [super createShape];
    
    sensorDetectionHero = [body addRectangleWithWidth:100 height:heightBody offset:cpv(-100 / 2, 0)];
    
    [sensorDetectionHero addToSpace];
}

- (void) defineShape {
    
    [super defineShape];
    
    [sensorDetectionHero setSensor:YES];
    [sensorDetectionHero setCollisionType:@"taedioAspire"];
}

- (void) simpleInit {
    
    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"taedioAspire" target:self begin:@selector(collisionStart: space:) preSolve:NULL postSolve:NULL separate:NULL];
}

- (BOOL) collisionStart:(CMArbiter*) arbiter space:(CMSpace*) space {
    
    if (!((Hero *)arbiter.shapeA.body.data).usingBouclier || !((Hero *)arbiter.shapeA.body.data).usingAutoDrive) {
        
        [((Hero *)arbiter.shapeA.body.data) hurt];
        
        [(AnimationSequence *)((CitrusObject *)arbiter.shapeB.body.data).graphic changeAnimation:@"taedioAspire" withLoop:NO];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"piege" object:nil];
    }
    
    return YES;
}

@end
