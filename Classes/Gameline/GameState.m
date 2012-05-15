//
//  GameState.m
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GameState.h"
#import "CitrusObject.h"
#import "PhysicsObject.h"
#import "Platform.h"
#import "Hero.h"
#import "AnimationSequence.h"
#import "BigPicture.h"
#import "Sensor.h"
#import "Sol.h"
#import "SBJson.h"
#import "BusManagement.h"
#import "CreationRuntime.h"

@implementation GameState

@synthesize couleurs;

- (id) init {
    
	if (self = [super init]) {
        
       //[self showHideDebugDraw];
        
        worldColor = @"rouge";
        
        gameWidth = 500680;
        
        couleurs = [[Couleurs alloc] initWithRouge:130 andBleu:20 andJaune:45 andOrange:12 andVert:8 andViolet:58];
        
        CitrusObject *parallaxe1 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"0.01", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"rouge_fond.png"]];
        [self addObject:parallaxe1];
        
        BigPicture *parallaxe2 = [[BigPicture alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andWorld:worldColor];
        [self addObject:parallaxe2];
        
        Platform *platformBot = [[Platform alloc] initWithName:@"platform" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", gameWidth / 2], @"320", [NSString stringWithFormat:@"%f", gameWidth], @"10", @"TRUE", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"isStatic:", nil]]];
        [self addObject:platformBot];
        
        AnimationSequence *mc = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"hero.xml"] andAnimations:[NSArray arrayWithObjects:@"base", @"descente", @"haut", @"passage_piege", @"saut", @"sol", nil] andFirstAnimation:@"base"];
        
        Hero *hero = [[Hero alloc] initWithName:@"hero" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"20", @"150", @"40", @"80", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:mc];
        [self addObject:hero];
        
        CitrusObject *firstPlan1 = [[CitrusObject alloc] initWithName:@"firstPlan1" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"250", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"rougeSol1.png"]];
        [self addObject:firstPlan1];
        
        [self setupCamera:hero andOffset:CGPointMake(hero.width / 2 - 80, 0) andBounds:CGRectMake(0, 0, gameWidth, 1000) andEasing:CGPointMake(0.25, 0.05)];
        
        BusManagement *bus = [[BusManagement alloc] initWithData:@"DonneesBus" andHero:hero];
        [bus start];
        
        CreationRuntime *creationRuntime = [[CreationRuntime alloc] initWithWorld:worldColor];
        [creationRuntime start];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"jaune" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"rouge" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"piege" object:nil];
	}
    
	return self;
}

- (void) colorPicked:(NSNotification *) notification {
    
    if ([notification.name isEqualToString:@"piege"]) {
        [couleurs piegeColor:worldColor];
    } else {
        [couleurs addColor:notification.name];
    }
    
}

@end
