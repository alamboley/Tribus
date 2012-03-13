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
        
        [self showHideDebugDraw];
        
        /** DEBUT A SUPPR **/
        
        /*CMBody *platform = [space addStaticBody];
        [platform setPositionUsingVect:cpv(250, 200)];
        
        CMShape *platformShape = [platform addRectangleWithWidth:200 height:10];
        [platformShape addToSpace];
        [platformShape setElasticity:0.7];
        [platformShape setFriction:0.7];
        [platformShape setCollisionType:@"platform"];
        
        int posX = arc4random() % 450;
        
        CMBody *block = [space addBodyWithMass:10.0 moment:INFINITY];
        [block addToSpace];
        [block setAngle:45];
        [block setPositionUsingVect:cpv(posX, 100)];
        
        CMShape *blockShape = [block addRectangleWithWidth:20 height:20];
        [blockShape setElasticity:0.7];
        [blockShape setFriction:0.7];
        [blockShape addToSpace];
        [blockShape setCollisionType:@"ball"];*/
        
        /** FIN A SUPPR **/
        
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
        
        SPQuad *quad = [SPQuad quadWithWidth:30 height:30 color:0xFF0000];
        SPImage *ballImage = [SPImage imageWithContentsOfFile:@"flash.png"];
        
        /*SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:@"Hero.xml"];
        NSArray *frames = [atlas texturesStartingWith:@"walk"];
         
        SPMovieClip *tiit = [[SPMovieClip alloc] initWithFrames:frames fps:25];*/
        
        
        AnimationSequence *mc = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"Hero.xml"] andAnimations:[NSArray arrayWithObjects:@"walk", @"jump", @"idle", nil] andFirstAnimation:@"idle"];
        
        Hero *hero = [[Hero alloc] initWithName:@"hero" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"20", @"50", @"20", @"20", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:mc];
        [self addObject:hero];
        
        /*CitrusObject *parallaxe3 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"parallaxe3.png"]];
        [self addObject:parallaxe3];
        
        CitrusObject *parallaxe4 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"1", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:@"parrallaxe4.png"]];
        [self addObject:parallaxe4];*/
        
        [self setupCamera:hero andOffset:CGPointMake(hero.width / 2, 0) andBounds:CGRectMake(0, 0, 2868, 1000) andEasing:CGPointMake(0.25, 0.05)];
        
        [self addEventListener:@selector(touched:) atObject:hero forType:SP_EVENT_TYPE_TOUCH];
	}
    
	return self;
}

@end
