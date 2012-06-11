//
//  CreationRuntime.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 07/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CreationRuntime.h"
#import "Particle.h"
#import "SXParticleSystem.h"
#import "Piege.h"
#import "GraphismTmp.h"
#import "FiltreDissociatif.h"
#import "FiltreAssociatif.h"

@implementation CreationRuntime

- (id) initWithWorld:(NSString *) worldColor {
    
    if (self = [super init]) {
        
        ce = [CitrusEngine getInstance];
        world = worldColor;
        
        animFiltreVertFrontDiss = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"filtreDissociatifVertFront.xml"] andAnimations:[NSArray arrayWithObjects:@"filtre", nil] andFirstAnimation:@"filtre"];
        animFiltreVertFrontAsso = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"filtreAssociatifVertFront.xml"] andAnimations:[NSArray arrayWithObjects:@"filtre", nil] andFirstAnimation:@"filtre"];
        
        particleTaken = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"particulesRecolte.xml"] andAnimations:[NSArray arrayWithObjects:@"particulesRecolte", nil] andFirstAnimation:@"particulesRecolte"];
        
        filtreBack = [SPImage imageWithContentsOfFile:@"filtreBack.png"];
    }
    
    return self;
}

- (void) destroy {
    
    [self stop];
    
    animFiltreVertFrontDiss = nil;
    animFiltreVertFrontAsso = nil;
    particleTaken = nil;
    filtreBack = nil;
}

- (void) start {
    
    timerParticle = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(onTickParticle:) userInfo:nil repeats:YES];
    timerPiege = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTickPiege:) userInfo:nil repeats:YES];
    timerDecor = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTickDecor:) userInfo:nil repeats:YES];
    
    hero = [ce.state getObjectByName:@"hero"];
}

- (void) stop {
    
    [timerParticle invalidate];
    timerParticle = nil;
    [timerPiege invalidate];
    timerPiege = nil;
    [timerDecor invalidate];
    timerDecor = nil;
}

- (void) onTickParticle:(NSTimer *) timer {
    
    int random = arc4random() % 4;
    
    if (random > 0) {
        
        float positionX = hero.x + 500 + arc4random() % 300;
        float positionY = 50 + arc4random() % 250;
        
        Particle *particleRandom = [[Particle alloc] initWithName:@"particleRandom" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:[world stringByAppendingString:@"Particle.pex"]] withWorld:world andAnim:particleTaken];
        [ce.state addObject:particleRandom];
    }
}

- (void) onTickPiege:(NSTimer *) timer {
    
    int random = arc4random() % 4;
    
    float positionX = hero.x + 500 + arc4random() % 300;
    float positionY = 50 + arc4random() % 250;
    
    if (random > 2) {
        
        Piege *piege = [[Piege alloc] initWithName:@"piege" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"20", @"100", @"3", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"piege.png"]];
        [ce.state addObject:piege];
        
    } else {
        
        GraphismTmp *filtrefake = [[GraphismTmp alloc] initWithName:@"filtreVert" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX - 235], [NSString stringWithFormat:@"%f", positionY - 180], @"40", @"80", @"1", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", @"parallax:", nil]] andGraphic:filtreBack];
        [ce.state addObject:filtrefake];
        
        if (random > 1) {
            
            FiltreDissociatif *filtreDissVert = [[FiltreDissociatif alloc] initWithName:@"filtreVert" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"40", @"80", @"3", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", nil]] andGraphic:[animFiltreVertFrontDiss copy] andColor:@"vert"];
            [ce.state addObject:filtreDissVert];
            
        } else {
            
            FiltreAssociatif *filtreAssoVert = [[FiltreAssociatif alloc] initWithName:@"filtreVert" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"40", @"80", @"3", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", nil]] andGraphic:[animFiltreVertFrontAsso copy] andColor:@"vert"];
            [ce.state addObject:filtreAssoVert];
        }
    }
}

- (void) onTickDecor:(NSTimer *) timer {
    
    if ([world isEqualToString:@"jaune"]) {
        
        int random = arc4random() % 4;
        
        float positionX = (hero.x + 500 + arc4random() % 300) * 2;
        
        if (random == 1) {
            
            GraphismTmp *firstPlan1 = [[GraphismTmp alloc] initWithName:@"firstPlan1" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], @"200", @"5", @"2", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", @"group:", nil]] andGraphic:[SPImage imageWithContentsOfFile:[world stringByAppendingString:@"1erplan1.png"]]];
            [ce.state addObject:firstPlan1];
            
        } else if (random == 2) {
            
            GraphismTmp *firstPlan2 = [[GraphismTmp alloc] initWithName:@"firstPlan2" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], @"200", @"5", @"2", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", @"group:", nil]] andGraphic:[SPImage imageWithContentsOfFile:[world stringByAppendingString:@"1erplan2.png"]]];
            [ce.state addObject:firstPlan2];
        }
    }
}

@end
