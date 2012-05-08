//
//  Particle.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 19/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Particle.h"
#import "SXParticleSystem.h"
#import "CitrusEngine.h"

@implementation Particle

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super initWithName:paramName params:params]) {
        
    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        if ([graphic isKindOfClass:[SXParticleSystem class]]) {
            [(SXParticleSystem *)graphic start];
            [[SPStage mainStage].juggler addObject:(SXParticleSystem *)graphic];
        }
    }
    
    return self;
}

- (void) destroy {
    
    [super destroy];
    
    if ([graphic isKindOfClass:[SXParticleSystem class]]) {
        
        [(SXParticleSystem *)graphic stop];
        [[SPStage mainStage].juggler removeObject:(SXParticleSystem *)graphic];
    }
    
    if (imgFond) {
        [self removeChild:imgFond];
    }
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
    
    [shape setCollisionType:@"particle"];
}


- (void) simpleInit {
    
    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"particle" target:self begin:@selector(collisionStart) preSolve:NULL postSolve:NULL separate:NULL];
}

- (void) collisionStart {
    

}

@end
