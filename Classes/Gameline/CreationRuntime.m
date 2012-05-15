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

@implementation CreationRuntime

- (id) initWithWorld:(NSString *) worldColor {
    
    if (self = [super init]) {
        
        ce = [CitrusEngine getInstance];
        world = worldColor;
    }
    
    return self;
}

- (void) start {
    
    timerParticle = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(onTickParticle:) userInfo:nil repeats:YES];
    timerPiege = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onTickPiege:) userInfo:nil repeats:YES];
    hero = [ce.state getObjectByName:@"hero"];
}

- (void) stop {
    
    [timerParticle invalidate];
    timerParticle = nil;
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
    
    if (random > 1) {
        
        float positionX = hero.x + 500 + arc4random() % 300;
        float positionY = 50 + arc4random() % 250;
    
        Piege *piege = [[Piege alloc] initWithName:@"piege" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"20", @"100", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"piege.png"]];
        [ce.state addObject:piege];
    }
}

@end
