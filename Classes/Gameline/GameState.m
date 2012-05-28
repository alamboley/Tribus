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
#import "ColorManager.h"

@implementation GameState

- (id) init {
    
	if (self = [super init]) {
        
        //[self showHideDebugDraw];
        
        worldColor = @"rouge";
        
        gameWidth = 500680;
        
        CitrusObject *parallaxe1 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"0.01", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:[worldColor stringByAppendingString:@"_fond.png"]]];
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"filtreDissociatif" object:nil];
	}
    
	return self;
}

- (void) colorPicked:(NSNotification *) notification {
    
    if ([notification.name isEqualToString:@"piege"]) {
        
        [ColorManager removePoints:10 forColorId:worldColor];
        
    } else if ([notification.name isEqualToString:@"filtreDissociatif"]) {
        
        [ColorManager filterDissociateForColorId:[[notification userInfo] valueForKey:@"colorId"]];
        
    } else {
        
        [ColorManager addPoints:1 forColorId:notification.name];
    }
    
}

@end
