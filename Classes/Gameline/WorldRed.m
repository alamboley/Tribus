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
        
        pouvoir = [SPImage imageWithContentsOfFile:@"pouvoir1-ingame.png"];
    }
    
    return self;
}

- (void) play {
    
    animHero = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"heroVert.xml"] andAnimations:[NSArray arrayWithObjects:@"base", @"descente", @"haut", @"fin", @"passage_piege", @"saut", @"sol", nil] andFirstAnimation:@"base"];
    
    timerRecupPouvoir = [NSTimer scheduledTimerWithTimeInterval:40 target:self selector:@selector(apparitionPouvoir:) userInfo:nil repeats:NO];
    
    [super play];
}

- (void) apparitionPouvoir:(NSTimer *) timer {
    
    pouvoirExchange = [[PouvoirExchange alloc]initWithImage:@"pouvoir1.png"];
    [self addChild:pouvoirExchange];
    [pouvoirExchange start];
    pouvoirExchange.x = hero.x + 450;
    [pouvoirExchange addEventListener:@selector(onPowerTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [timerRecupPouvoir invalidate];
    timerRecupPouvoir = nil;
}

- (void) onPowerTouched:(SPTouchEvent *) event {
    
    [event stopPropagation];
    
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    
    if (touch) {
        [pouvoirExchange destroy];
        [pouvoirExchange removeEventListener:@selector(onPowerTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        
        [self.stage addChild:pouvoir];
        pouvoir.rotation = SP_D2R(90);
        pouvoir.x = 50;
        pouvoir.y = 430;
        [pouvoir addEventListener:@selector(onPowerUsed:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
}

- (void) prochainArret:(NSNotification *) notification {
    
    CitrusObject *panneau = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 500], @"200", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"sommeiller300m.png"]];
    [self addObject:panneau];
    
    CitrusObject *fondArrivee = [[CitrusObject alloc] initWithName:@"fondArrivee" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 1750], @"50", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:imgArrivee];
    [self addObject:fondArrivee];
    
    CitrusObject *panneauEnd = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 1700], @"200", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"sommeiller.png"]];
    [self addObject:panneauEnd];
    
    bus.creerEnnemis = NO;
    [creationRuntime stop];
}

- (void) finNiveau:(NSNotification *) notification {
    
    [super finNiveau:notification];
}

- (void) destroy {
    
    if (pouvoir) {
        [self.stage removeChild:pouvoir];
        [pouvoir removeEventListener:@selector(onPowerTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        pouvoir = nil;
    }
    
    [super destroy];
}

- (void) onPowerUsed:(SPTouchEvent *) event {
    
    [self.stage removeChild:pouvoir];
    [pouvoir removeEventListener:@selector(onPowerUsed:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    pouvoir = nil;
    
    [hero startBouclier];
}

@end