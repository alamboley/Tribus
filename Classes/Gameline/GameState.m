//
//  GameState.m
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GameState.h"
#import "CitrusObject.h"
#import "Platform.h"
#import "BigPicture.h"
#import "Sensor.h"
#import "Sol.h"
#import "ColorManager.h"
#import "EcranFumee.h"
#import "PouvoirExchange.h"
#import "FondParallax.h"

@implementation GameState

- (id) init {
    
	if (self = [super init]) {
        
        //[USave saveItemId:[obj objectForKey:@"id"] forType:self.title];
        
        gameWidth = 500680;
        
        //FondParallax *parallaxe1 = [[FondParallax alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andWorld:worldColor];
        //[self addObject:parallaxe1];
        
        CitrusObject *parallaxe1 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"0.1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:[worldColor stringByAppendingString:@"_fond.png"]]];
        [self addObject:parallaxe1];
        
        BigPicture *parallaxe2 = [[BigPicture alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andWorld:worldColor];
        [self addObject:parallaxe2];
        
        Platform *platformBot = [[Platform alloc] initWithName:@"platform" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", gameWidth / 2], @"320", [NSString stringWithFormat:@"%f", gameWidth], @"10", @"TRUE", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"isStatic:", nil]]];
        [self addObject:platformBot];
        
        CitrusObject *firstPlan1 = [[CitrusObject alloc] initWithName:@"firstPlan1" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"250", @"1.5", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"rougeSol1.png"]];
        [self addObject:firstPlan1];
        
        AnimationSequence *mc = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"hero.xml"] andAnimations:[NSArray arrayWithObjects:@"base", @"descente", @"haut", @"fin", @"passage_piege", @"saut", @"sol", nil] andFirstAnimation:@"base"];
        
        hero = [[Hero alloc] initWithName:@"hero" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"20", @"150", @"40", @"80", @"2", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", nil]] andGraphic:mc];
        [self addObject:hero];
        
        [self setupCamera:hero andOffset:CGPointMake(hero.width / 2 - 80, 0) andBounds:CGRectMake(0, 0, gameWidth, 1000) andEasing:CGPointMake(0.25, 0.05)];
        
        bus = [[BusManagement alloc] initWithData:@"DonneesBus" andHero:hero];
        [bus start];
        
        creationRuntime = [[CreationRuntime alloc] initWithWorld:worldColor];
        [creationRuntime start];
        
        animEcranNoir = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"ecranNoir.xml"] andAnimations:[NSArray arrayWithObjects:@"noirDisparition", @"noirExplosion", nil] andFirstAnimation:@"noirExplosion"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finNiveau:) name:@"finNiveau" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"jaune" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"rouge" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"piege" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"filtreDissociatif" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"filtreAssociatif" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baddyManagement:) name:@"ecranFumee" object:nil];
        
        /*PouvoirExchange *pv = [[PouvoirExchange alloc]initWithImage:@"pouvoir1.png"];
        [self addChild:pv];
        [pv start];
        
        [pv addEventListener:@selector(onPowerTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];*/
    }
    
	return self;
}

- (void) destroy {
    
    // may bug ?
    [bus destroy];
    [creationRuntime destroy];
    
    animEcranNoir = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super destroy];
}

- (void) onPowerTouched:(SPTouchEvent *) event {
    
    [event stopPropagation];
    
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    
    if (touch) {
        //[pv destroy];
        //[pv removeEventListener:@selector(onPowerTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
}

- (void) finNiveau:(NSNotification *) notification {
    
    hero.move = FALSE;
}

- (void) colorPicked:(NSNotification *) notification {
    
    if ([notification.name isEqualToString:@"piege"]) {
        
        [ColorManager removePoints:10 forColorId:worldColor];
        
    } else if ([notification.name isEqualToString:@"filtreDissociatif"]) {
        
        [ColorManager filterDissociateForColorId:[[notification userInfo] valueForKey:@"colorId"]];
        
    } else if ([notification.name isEqualToString:@"filtreAssociatif"]) {
        
        [ColorManager filterAssociateForColorId:[[notification userInfo] valueForKey:@"colorId"]];
        
    } else {
        
        [ColorManager addPoints:1 forColorId:notification.name];
    }
    
}

- (void) baddyManagement:(NSNotification *) notification {
    
    EcranFumee *ecranFumee = [[EcranFumee alloc] initWithAnimationSequence:animEcranNoir];
    [self.stage addChild:ecranFumee];
}

@end
