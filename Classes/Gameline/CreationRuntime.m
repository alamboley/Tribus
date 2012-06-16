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
#import "Stats.h"

@implementation CreationRuntime

- (id) initWithWorld:(NSString *) worldColor {
    
    if (self = [super init]) {
        
        ce = [CitrusEngine getInstance];
        world = worldColor;
        
        animFiltreAssoOrangeBack = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"filtreAssociatifOrangeBack.xml"] andAnimations:[NSArray arrayWithObjects:@"filtre", nil] andFirstAnimation:@"filtre"];
        animFiltreAssoOrangeFront = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"filtreAssociatifOrangeFront.xml"] andAnimations:[NSArray arrayWithObjects:@"filtre", nil] andFirstAnimation:@"filtre"];
        
        particleTaken = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"particulesRecolte.xml"] andAnimations:[NSArray arrayWithObjects:@"particulesRecolte", nil] andFirstAnimation:@"particulesRecolte"];
        
        filtreBack = [SPImage imageWithContentsOfFile:@"filtreBack.png"];
        
        [Stats initStats];
    }
    
    return self;
}

- (void) destroy {
    
    [self stop];
    
    startTime = nil;
    
    animFiltreAssoOrangeBack = nil;
    animFiltreAssoOrangeFront = nil;
    particleTaken = nil;
    filtreBack = nil;
}

- (void) start {
    
    timerParticle = [NSTimer scheduledTimerWithTimeInterval:[world isEqualToString:@"jaune"] ? 0.7 : 1.5 target:self selector:@selector(onTickParticle:) userInfo:nil repeats:YES];
    timerPiege = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTickPiege:) userInfo:nil repeats:YES];
    timerDecor = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTickDecor:) userInfo:nil repeats:YES];
    
    startTime = [[NSDate alloc] init];
    
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
        
        Particle *particleRandom = [[Particle alloc] initWithName:@"particleRandom" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:[world stringByAppendingString:@"Particle.pex"]] withWorld:world];
        [ce.state addObject:particleRandom];
        
        [Stats addParticule];
    }
}

- (void) onTickPiege:(NSTimer *) timer {
    
    int random = arc4random() % 4;
    
    float positionX = hero.x + 500 + arc4random() % 300;
    float positionY = 50 + arc4random() % 250;
    
    if ([world isEqualToString:@"rouge"] && ([startTime timeIntervalSinceNow] > -85 && [startTime timeIntervalSinceNow] < -80)) {
        
        Sensor *filtrefake = [[Sensor alloc] initWithName:@"filtreOrangeFake" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"40", @"80", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", nil]] andGraphic:[animFiltreAssoOrangeBack copy]];
        [ce.state addObject:filtrefake];
        
        FiltreAssociatif *filtreAssoOrange = [[FiltreAssociatif alloc] initWithName:@"filtreOrange" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"40", @"80", @"3", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", nil]] andGraphic:[animFiltreAssoOrangeFront copy] andColor:@"orange"];
        [ce.state addObject:filtreAssoOrange];
        
    } else if (random > 1 && [startTime timeIntervalSinceNow] < -15) {
        
        Piege *piege = [[Piege alloc] initWithName:@"piege" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"20", @"100", @"3", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"piege.png"]];
        [ce.state addObject:piege];
        
    }
}

- (void) onTickDecor:(NSTimer *) timer {
    
    if ([world isEqualToString:@"jaune"] && [startTime timeIntervalSinceNow] < -5) {
        
        int random = arc4random() % 4;
        
        float positionX = (hero.x + 500 + arc4random() % 300) * 3;
        
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
