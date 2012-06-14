//
// WorldRed.m
// ChipmunkWrapper
//
// Created by Aymeric Lamboley on 01/06/12.
// Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "WorldRed.h"

@implementation WorldRed

- (id) init {
    
    worldColor = @"rouge";
    
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prochainArret:) name:@"prochainArret" object:nil];
        
        imgArrivee = [SPImage imageWithContentsOfFile:[worldColor stringByAppendingString:@"Arrivee.png"]];
    }
    
    return self;
}

- (void) play {
    
    animHero = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"heroVert.xml"] andAnimations:[NSArray arrayWithObjects:@"base", @"descente", @"haut", @"fin", @"passage_piege", @"saut", @"sol", nil] andFirstAnimation:@"base"];
    
    timerRecupPouvoir = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(apparitionPouvoir:) userInfo:nil repeats:YES];
    
    [super play];
    
    NSLog(@"1");
}

- (void) apparitionPouvoir:(NSTimer *) timer {
    NSLog(@"2");    
    pouvoirExchange = [[PouvoirExchange alloc]initWithImage:@"pouvoir1-ingame.png"];
    [self addChild:pouvoirExchange];
    [pouvoirExchange start];
    [pouvoirExchange addEventListener:@selector(onPowerTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [timerRecupPouvoir invalidate];
    timerRecupPouvoir = nil;
}

- (void) onPowerTouched:(SPTouchEvent *) event {
    
    [event stopPropagation];
    
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    
    if (touch) {
        //[pv destroy];
        //[pv removeEventListener:@selector(onPowerTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
}

- (void) prochainArret:(NSNotification *) notification {
    
    CitrusObject *panneau = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 500], @"200", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"sommeiller300m.png"]];
    [self addObject:panneau];
    
    CitrusObject *panneauEnd = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 1700], @"200", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"sommeiller.png"]];
    [self addObject:panneauEnd];
    
    CitrusObject *fondArrivee = [[CitrusObject alloc] initWithName:@"fondArrivee" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 1800], @"50", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:imgArrivee];
    [self addObject:fondArrivee];
    
    bus.creerEnnemis = NO;
    [creationRuntime stop];
}

- (void) finNiveau:(NSNotification *) notification {
    
    [super finNiveau:notification];
}

- (void) destroy {
    
    [super destroy];
}

@end