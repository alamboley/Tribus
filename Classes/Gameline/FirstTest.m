//
//  FirstTest.m
//  Gameline
//
//  Created by Aymeric Lamboley on 14/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "FirstTest.h"
#import "CarreFlash.h"

@interface FirstTest() 

- (void) addBlock;

@end

@implementation FirstTest

- (BOOL)disableAccelerometer {
	return YES;
}

- (BOOL)disableWindowContainment {
	return NO;
}

- (BOOL)disableDefaultTouchHandler {
	return YES;
}

- (void) initializeChipmunkObjects {
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(targetMethod:) userInfo:nil repeats:YES];
    
    CMBody *platform = [mSpace addStaticBody];
    [platform addToSpace];
    [platform setPositionUsingVect:cpv(250, 200)];
    
    CMShape *platformShape = [platform addRectangleWithWidth:200 height:10];
    [platformShape addToSpace];
    [platformShape setElasticity:0.7];
    [platformShape setFriction:0.7];
    [platformShape setCollisionType:@"platform"];
    
    CMShape *platformShape2 = [platform addRectangleWithWidth:200 height:10 offset:cpv(50, 50)];
    [platformShape2 addToSpace];
    [platformShape2 setElasticity:0.7];
    [platformShape2 setFriction:0.7];
    
    NSMutableDictionary *dictionnary = [[NSMutableDictionary alloc] init];
    [dictionnary setObject:@"object one" forKey:@"1"];
    
    NSObject *monObjet = [[NSObject alloc] init];
    
    [dictionnary setObject:monObjet forKey:@"2"];
    
    NSLog(@"%@", [dictionnary objectForKey:@"2"]);
    
    
    //[mSpace addCollisionHandlerBetween:@"platform" andTypeB:@"ball" target:self selector:@selector(collisionAmoi)];
    
    [mSpace addCollisionHandlerBetween:@"platform" andTypeB:@"ball" target:self begin:@selector(collisionAmoi) preSolve:NULL postSolve:NULL separate:NULL];
}

- (void) collisionAmoi {
    
    NSLog(@"ok ?");
}

- (void) startDemo {
    
    [super startDemo];
    
    SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:@"Hero.xml"];
    NSArray *frames = [atlas texturesStartingWith:@"walk"];
    
    SPMovieClip *mc = [[SPMovieClip alloc] initWithFrames:frames fps:25];
    [self addChild:mc];

    [self.stage.juggler addObject:mc];
}

- (void) targetMethod:(NSTimer *) timer {
    
    [self addBlock];
}

- (void) addBlock {
    
    //NSLog([NSString stringWithFormat:@"%d", arc4random() % 450]);
    
    int posX = arc4random() % 450;
    
    CarreFlash *carreFlash = [[CarreFlash alloc] init];
	[carreFlash setX:posX];
	[carreFlash setY:100];
	[self addChild:carreFlash];
    
    CMBody *block = [mSpace addBodyWithMass:10.0 moment:INFINITY];
	[block addToSpace];
    [block setAngle:45];
    [block setPositionUsingVect:cpv(posX, 100)];
    [block setData:carreFlash];
    
	CMShape *blockShape = [block addRectangleWithWidth:20 height:20];
	[blockShape setElasticity:0.7];
	[blockShape setFriction:0.7];
	[blockShape addToSpace];
    [blockShape setCollisionType:@"ball"];
}

@end
