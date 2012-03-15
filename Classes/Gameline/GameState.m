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

@implementation GameState

- (id) init {
    
	if (self = [super init]) {
        
        //[self showHideDebugDraw];
        
        //SPImage *backgroundImage = 
        
        /*CitrusObject *parallaxe1 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"parallaxe1.jpg"]];
        [self addObject:parallaxe1]; 
        
        CitrusObject *parallaxe2 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"parallaxe2.png"]];
        [self addObject:parallaxe2];*/
        
        BigPicture *parallaxe2 = [[BigPicture alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"0.5", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andPictures:[NSArray arrayWithObjects:@"parallaxe2-1.png", @"parallaxe2-2.png", @"parallaxe2-3.png", nil]];
        [self addObject:parallaxe2];

        Platform *platform = [[Platform alloc] initWithName:@"platform" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"200", @"320", @"2000", @"10", @"TRUE", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"isStatic:", nil]]];
        [self addObject:platform];
        
        Platform *platform2 = [[Platform alloc] initWithName:@"platform" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"200", @"0", @"2000", @"10", @"TRUE", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"isStatic:", nil]]];
        [self addObject:platform2];
        
        AnimationSequence *mc = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"Hero.xml"] andAnimations:[NSArray arrayWithObjects:@"walk", @"jump", @"idle", nil] andFirstAnimation:@"idle"];
        
        Hero *hero = [[Hero alloc] initWithName:@"hero" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"20", @"50", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:mc];
        [self addObject:hero];
        
        /*CitrusObject *parallaxe3 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"parallaxe3.png"]];
        [self addObject:parallaxe3];
        
        CitrusObject *parallaxe4 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"parrallaxe4.png"]];
        [self addObject:parallaxe4];*/
        
        [self setupCamera:hero andOffset:CGPointMake(hero.width / 2, 0) andBounds:CGRectMake(0, 0, 2868, 1000) andEasing:CGPointMake(0.25, 0.05)];
	}
    
	return self;
}

@end
