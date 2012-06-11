//
//  WorldYellow.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 01/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "WorldYellow.h"
#import "Jauge.h"

@implementation WorldYellow

- (id) init {
    
    worldColor = @"jaune";
    
	if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prochainArret:) name:@"prochainArret" object:nil];
        
        imgArrivee = [SPImage imageWithContentsOfFile:[worldColor stringByAppendingString:@"Arrivee.png"]];
    }
    
    return self;
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
    
    Jauge *jauge = [[Jauge alloc] initWithColor:worldColor];
    [self addChild:jauge];
    jauge.x = hero.x + 430;
    jauge.y = 170;
    
}

- (void) destroy {
    
    [super destroy];
}

@end
