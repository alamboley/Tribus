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

@implementation CreationRuntime

- (id) initWithWorld:(NSString *) worldColor {
    
    if (self = [super init]) {
        
        ce = [CitrusEngine getInstance];
        world = worldColor;
        
        animFiltreVertFront = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"filtreDissociatifVertFront.xml"] andAnimations:[NSArray arrayWithObjects:@"filtre", nil] andFirstAnimation:@"filtre"];
        
        filtreBack = [SPImage imageWithContentsOfFile:@"filtreBack.png"];
    }
    
    return self;
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
        
        Particle *particleRandom = [[Particle alloc] initWithName:@"particleRandom" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:[world stringByAppendingString:@"Particle.pex"]] withWorld:world];
        [ce.state addObject:particleRandom];
    }
}

- (void) onTickPiege:(NSTimer *) timer {
    
    int random = arc4random() % 4;
    
    float positionX = hero.x + 500 + arc4random() % 300;
    float positionY = 50 + arc4random() % 250;
    
    if (random > 1) {
        
        Piege *piege = [[Piege alloc] initWithName:@"piege" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"20", @"100", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"piege.png"]];
        [ce.state addObject:piege];
        
    } else {
        
        GraphismTmp *filtrefake = [[GraphismTmp alloc] initWithName:@"filtreVert" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX - 235], [NSString stringWithFormat:@"%f", positionY - 180], @"40", @"80", @"0", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", @"parallax:", nil]] andGraphic:filtreBack];
        [ce.state addObject:filtrefake];
        
        FiltreDissociatif *filtreVert = [[FiltreDissociatif alloc] initWithName:@"filtreVert" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"40", @"80", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:animFiltreVertFront andColor:@"vert"];
        [ce.state addObject:filtreVert];
    }
}

- (void) onTickDecor:(NSTimer *) timer {
    
    int random = arc4random() % 4;
    
    float positionX = (hero.x + 500 + arc4random() % 300) * 2;
    float positionY = 50 + arc4random() % 250;
    
    if (random == 1) {
        
        GraphismTmp *firstPlan1 = [[GraphismTmp alloc] initWithName:@"firstPlan1" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], @"200", @"2", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:[world stringByAppendingString:@"1erplan1.png"]]];
        [ce.state addObject:firstPlan1];
        
    } else if (random == 2) {

        GraphismTmp *firstPlan2 = [[GraphismTmp alloc] initWithName:@"firstPlan2" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], @"200", @"2", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:[world stringByAppendingString:@"1erplan2.png"]]];
        [ce.state addObject:firstPlan2];
    }
}

@end
