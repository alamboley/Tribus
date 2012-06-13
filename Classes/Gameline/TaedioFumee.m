//
//  TaedioFumee.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 29/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "TaedioFumee.h"
#import "CitrusEngine.h"
#import "Hero.h"

@implementation TaedioFumee

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

- (void) defineShape {
    
    [super defineShape];
    
    [shape setSensor:YES];
    [shape setCollisionType:@"taedioFumee"];
}

- (void) simpleInit {
    
    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"taedioFumee" target:self begin:@selector(collisionStart:) preSolve:NULL postSolve:NULL separate:@selector(collisionEnd)];
}

- (BOOL) collisionStart:(CMArbiter*) arbiter space:(CMSpace*) space {
    
    if (!((Hero *)arbiter.shapeA.body.data).usingBouclier || !((Hero *)arbiter.shapeA.body.data).usingAutoDrive) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ecranFumee" object:nil];
    }
    
    return YES;
}

@end
