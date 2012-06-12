//
// WorldYellow.m
// ChipmunkWrapper
//
// Created by Aymeric Lamboley on 01/06/12.
// Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "WorldYellow.h"

@implementation WorldYellow

- (id) init {
    
    worldColor = @"jaune";
    
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prochainArret:) name:@"prochainArret" object:nil];
        
        imgArrivee = [SPImage imageWithContentsOfFile:[worldColor stringByAppendingString:@"Arrivee.png"]];
        
        portalRed = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"portailRouge.xml"] andAnimations:[NSArray arrayWithObjects:@"portailrouge", nil] andFirstAnimation:@"portailrouge"];
    }
    
    return self;
}

- (void) play {
    
    animHero = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"hero.xml"] andAnimations:[NSArray arrayWithObjects:@"base", @"descente", @"haut", @"fin", @"passage_piege", @"saut", @"sol", nil] andFirstAnimation:@"base"];
    
    [super play];
}

- (void) prochainArret:(NSNotification *) notification {
    
    CitrusObject *panneau = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 500], @"200", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"bonlieu300m.png"]];
    [self addObject:panneau];
    
    CitrusObject *panneauEnd = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 1700], @"200", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"bonlieu.png"]];
    [self addObject:panneauEnd];
    
    CitrusObject *fondArrivee = [[CitrusObject alloc] initWithName:@"fondArrivee" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", hero.x + 1800], @"50", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:imgArrivee];
    [self addObject:fondArrivee];
    
    bus.creerEnnemis = NO;
    [creationRuntime stop];
}

- (void) finNiveau:(NSNotification *) notification {
    
    [super finNiveau:notification];
    
    jauge = [[Jauge alloc] initWithColor:worldColor];
    [self addChild:jauge];
    jauge.x = hero.x + 430;
    jauge.y = 170;
    
    [self addChild:portalRed];
    portalRed.x = hero.x + 400;
    portalRed.y = 100;
    
    [portalRed addEventListener:@selector(changeLevel:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void) changeLevel:(SPTouchEvent *) event {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNiveau" object:nil];
}

- (void) destroy {
    
    [self removeChild:portalRed];
    [portalRed removeEventListener:@selector(changeLevel:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self removeChild:jauge];
    [jauge destroy];
    
    portalRed = nil;
    
    imgArrivee = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super destroy];
}

@end