
//
//  FiltreDissociatif.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 16/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "FiltreDissociatif.h"
#import "CitrusEngine.h"
#import "Hero.h"

@implementation FiltreDissociatif

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject andColor:(NSString *) worldColor {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        color = worldColor;
        
    }
    
    return self;
}

- (void) destroy {
    
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

- (void) defineShape {
    
    [super defineShape];
    
    [shape setCollisionType:@"filtreDissociatif"];
}

- (void) simpleInit {
    
    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"filtreDissociatif" target:self begin:@selector(collisionStart: space:) preSolve:NULL postSolve:NULL separate:@selector(collisionEnd: space:)];

}

- (BOOL) collisionStart:(CMArbiter*) arbiter space:(CMSpace*) space {
    
    ((Hero *)arbiter.shapeA.body.data).animation = @"passage_piege";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"filtreDissociatif" object:nil];
    
    return YES;
}

- (BOOL) collisionEnd:(CMArbiter*) arbiter space:(CMSpace*) space {
    
    ((Hero *)arbiter.shapeA.body.data).animation = @"base";
    
    return YES;
}

@end
