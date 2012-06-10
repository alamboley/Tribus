//
//  FiltreAssociatif.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 10/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "FiltreAssociatif.h"
#import "CitrusEngine.h"
#import "Hero.h"

@implementation FiltreAssociatif

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
    
    [shape setCollisionType:@"filtreAssociatif"];
}

- (void) simpleInit {
    
    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"filtreAssociatif" target:self begin:@selector(collisionStart: space:) preSolve:NULL postSolve:NULL separate:@selector(collisionEnd: space:)];
    
}

- (BOOL) collisionStart:(CMArbiter*) arbiter space:(CMSpace*) space {
    
    ((Hero *)arbiter.shapeA.body.data).animation = @"passage_piege";
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          color, @"colorId", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"filtreAssociatif" object:nil userInfo:dict];
    
    return YES;
}

- (BOOL) collisionEnd:(CMArbiter*) arbiter space:(CMSpace*) space {
    
    ((Hero *)arbiter.shapeA.body.data).animation = @"base";
    
    return YES;
}

@end