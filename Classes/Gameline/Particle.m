//
// Particle.m
// ChipmunkWrapper
//
// Created by Aymeric Lamboley on 19/03/12.
// Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Particle.h"
#import "SXParticleSystem.h"
#import "CitrusEngine.h"
#import "Hero.h"
#import "Stats.h"

@implementation Particle
@synthesize prise;

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super initWithName:paramName params:params]) {
        
    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject withWorld:(NSString *)world andAnim:(AnimationSequence *)animParticleTaken {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        worldColor = world;
        
        if ([graphic isKindOfClass:[SXParticleSystem class]]) {
            [(SXParticleSystem *)graphic start];
            [[SPStage mainStage].juggler addObject:(SXParticleSystem *)graphic];
            
            if ([worldColor isEqualToString:@"jaune"]) {
                imgFond = [SPImage imageWithContentsOfFile:@"particleFondJaune.png"];
            } else if ([worldColor isEqualToString:@"rouge"]) {
                imgFond = [SPImage imageWithContentsOfFile:@"particleFondRouge.png"];
            }
            
            [self addChild:imgFond atIndex:0];
            
            imgFond.x = posX - imgFond.width / 2;
            imgFond.y = posY - imgFond.height / 2;
        }
        
        particleTaken = [animParticleTaken copy];
    }
    
    return self;
}


- (void) destroy {
    
    [super destroy];
    
    if (prise) {
        
        [self removeChild:particleTaken];
        
        
    } else {
        
        if ([graphic isKindOfClass:[SXParticleSystem class]]) {
            [(SXParticleSystem *)graphic stop];
            [[SPStage mainStage].juggler removeObject:(SXParticleSystem *)graphic];
        }
        
        [self removeChild:imgFond];
    }
}

- (void) update {
    
    [super update];
    
    if (!hero) {
        
        hero = [ce.state getObjectByName:@"hero"];
        
    } else {
        
        if (hero.x - hero.width > body.position.x) {
            
            particleTaken = nil;
            
            self.kill = YES;
        }
    }
}

- (void) defineShape {
    
    [super defineShape];
    
    [shape setCollisionType:@"particle"];
}


- (void) simpleInit {
    
    [super.space addCollisionHandlerBetween:@"hero" andTypeB:@"particle" target:self begin:@selector(collisionStart: space:) preSolve:NULL postSolve:NULL separate:NULL];
    
    prise = FALSE;
}

- (void) addParticlePrise {
    
    [particleTaken changeAnimation:@"particulesRecolte" withLoop:NO];
    
    [self addChild:particleTaken];
    
    particleTaken.x = posX - particleTaken.width / 2;
    particleTaken.y = posY - particleTaken.height / 2;
    
    [(SXParticleSystem *)graphic stop];
    [[SPStage mainStage].juggler removeObject:(SXParticleSystem *)graphic];
    [self removeChild:imgFond];
    
    [self removeChild:graphic];
    
    prise = true;
}

- (BOOL) collisionStart:(CMArbiter*) arbiter space:(CMSpace*) space {
    
    if (!((Hero *)arbiter.shapeA.body.data).usingAutoDrive) {
        
        //((CitrusObject *)arbiter.shapeB.body.data).kill = YES;
        [((Particle *)arbiter.shapeB.body.data) addParticlePrise];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:worldColor object:nil];
        [Stats particuleCaptured];
    }
    
    return YES;
}

@end