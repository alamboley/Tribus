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
#import "SXParticleSystem.h"
#import "Piege.h"
#import "ParticleJaune.h"
#import "Sol.h"
#import "SBJson.h"
#import "BusManagement.h"

@implementation GameState

@synthesize couleurs;

- (id) init {
    
	if (self = [super init]) {
        
        //[self showHideDebugDraw];
        
        gameWidth = 28680;
        
        couleurs = [[Couleurs alloc] initWithRouge:130 andBleu:20 andJaune:45 andOrange:12 andVert:8 andViolet:58];
        
        CitrusObject *parallaxe1 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"0.01", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"parallaxe2.png"]];
        [self addObject:parallaxe1];
        
        BigPicture *parallaxe2 = [[BigPicture alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andWorld:@"WorldYellow"];
        [self addObject:parallaxe2];
        
        Platform *platformBot = [[Platform alloc] initWithName:@"platform" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", gameWidth / 2], @"320", [NSString stringWithFormat:@"%f", gameWidth], @"10", @"TRUE", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"isStatic:", nil]]];
        [self addObject:platformBot];
        
        //AnimationSequence *mc = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"hero.xml"] andAnimations:[NSArray arrayWithObjects:@"walk", @"idle", nil] andFirstAnimation:@"idle"];
        
        AnimationSequence *mc = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"hero.xml"] andAnimations:[NSArray arrayWithObjects:@"acc", @"pass", nil] andFirstAnimation:@"acc"];
        
        Hero *hero = [[Hero alloc] initWithName:@"hero" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"20", @"150", @"40", @"60", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:mc];
        [self addObject:hero];
        
        Piege *piege = [[Piege alloc] initWithName:@"piege" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1900", @"200", @"20", @"100", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"piege.png"]];
        [self addObject:piege];
        
        ParticleJaune *particle0 = [[ParticleJaune alloc] initWithName:@"particle0" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"300", @"250", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:@"jauneParticle.pex"]];
        [self addObject:particle0];
        
        ParticleJaune *particle1 = [[ParticleJaune alloc] initWithName:@"particle" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"500", @"50", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:@"jauneParticle.pex"]];
        [self addObject:particle1];
        
        ParticleJaune *particle2 = [[ParticleJaune alloc] initWithName:@"particle" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"650", @"150", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:@"jauneParticle.pex"]];
        [self addObject:particle2];
        
        ParticleJaune *particle3 = [[ParticleJaune alloc] initWithName:@"particle3" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"900", @"250", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:@"jauneParticle.pex"]];
        [self addObject:particle3];
        
        ParticleJaune *particle4 = [[ParticleJaune alloc] initWithName:@"particle3" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1200", @"250", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:@"jauneParticle.pex"]];
        [self addObject:particle4];
        
        ParticleJaune *particle5 = [[ParticleJaune alloc] initWithName:@"particle3" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1300", @"250", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:@"jauneParticle.pex"]];
        [self addObject:particle5];
        
        ParticleJaune *particle6 = [[ParticleJaune alloc] initWithName:@"particle3" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1500", @"200", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[SXParticleSystem particleSystemWithContentsOfFile:@"jauneParticle.pex"]];
        [self addObject:particle6];
        
        CitrusObject *firstPlan1 = [[CitrusObject alloc] initWithName:@"firstPlan1" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1500", @"200", @"2", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"1erplan.png"]];
        [self addObject:firstPlan1];
        
        CitrusObject *firstPlan2 = [[CitrusObject alloc] initWithName:@"firstPlan2" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"3000", @"200", @"2", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"1erplan2.png"]];
        [self addObject:firstPlan2];
        
        [self setupCamera:hero andOffset:CGPointMake(hero.width / 2, 0) andBounds:CGRectMake(0, 0, gameWidth, 1000) andEasing:CGPointMake(0.25, 0.05)];
        
        BusManagement *bus = [[BusManagement alloc] initWithData:@"DonneesBus" andHero:hero];
        [bus start];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"colorJaune" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"piege" object:nil];
	}
    
	return self;
}

- (void) colorPicked:(NSNotification *) notification {
    
    if ([notification.name isEqualToString:@"piege"]) {
        [couleurs piegeColor:@"colorJaune"];
    } else {
        [couleurs addColor:notification.name];
    }
    
}

@end
