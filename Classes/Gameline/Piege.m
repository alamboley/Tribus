//
//  Piege.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 20/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Piege.h"
#import "CitrusEngine.h"
#import "Hero.h"

@implementation Piege

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

- (void) destroy {
    
    [super destroy];
}

- (void) defineShape {
    
    [super defineShape];
    
    [shape setCollisionType:@"piege"];
}

- (void) createBody {
    
    if (isStatic == 0) {
        
        body = [space addBodyWithMass:5.0 moment:INFINITY];
        [body addToSpace];
        
    } else {
        
        body = [space addStaticBody];
    }
    
}

- (void) update {
    
    [super update];
    
    cpVect velocity = [body velocity];
    
    if (body.position.y > 130) {
        velocity.y -= 12;
    } else {
        velocity.y += 12;
    }
    
    [body setVelocity:velocity];
    
    
    if (!hero) {
        
        hero = [ce.state getObjectByName:@"hero"];
        
    } else {
        
        if (hero.x - hero.width > body.position.x) {
            
            self.kill = YES;
        }
    }
    
}


- (void) simpleInit {

    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"piege" target:self begin:@selector(collisionStart: space:) preSolve:NULL postSolve:NULL separate:NULL];
}

- (BOOL) collisionStart:(CMArbiter*) arbiter space:(CMSpace*) space {
    
    Hero *theHero;
    
    if ([((CitrusObject *)arbiter.shapeA.body.data).name isEqualToString:@"hero"]) {
        theHero = (Hero *)arbiter.shapeA.body.data;
    } else {
        theHero = (Hero *)arbiter.shapeB.body.data;
    }
    
    if (!theHero.usingBouclier || !theHero.usingAutoDrive) {
        
        [theHero hurt];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"piege" object:nil];
    }
    
    return YES;
}

@end
