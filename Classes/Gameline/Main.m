//
//  Main.m
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Main.h"
#import "WorldRed.h"
#import "WorldYellow.h"

@implementation Main

- (id)initWithWidth:(float)width height:(float)height rotation:(BOOL)rotation {
    
    if (self = [super initWithWidth:width height:height rotation:rotation]) {
        
        rotate = rotation;
        
        if (startingColor == nil) startingColor = @"jaune";
        
        if ([startingColor isEqualToString:@"jaune"])
            game = [WorldYellow alloc];
        else 
            game = [WorldRed alloc];
        
        [game setDelegate:self];
        [game setWidth:320];
        [game setHeight:480];
        
        if (rotate == YES) {
            game.rotation = SP_D2R(90);
            game.x = 320;
        }
        
        [super setUpState:game];
        
        frameRateTextField.visible = TRUE;
        
        imgLoading = [SPImage imageWithContentsOfFile:@"loading-bg.png"];
        imgLoading.rotation = SP_D2R(90);
        imgLoading.x = 320;
        
        [self.stage addChild:imgLoading];
        
        play = [SPImage imageWithContentsOfFile:@"play-btn.png"];
        play.rotation = SP_D2R(90);
        play.x = 80;
        play.y = 180;
        
        [self.stage addChild:play];
        
        [play addEventListener:@selector(startGame:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finNiveau:) name:@"finNiveau" object:nil];
    
    return self;
}

- (id)initWithWidth:(float)width height:(float)height rotation:(BOOL)rotation andStartingColor:(NSString *) startingColorId {
    
    startingColor = startingColorId;

     if (self = [self initWithWidth:width height:height rotation:rotation]) {
         
     }
    
    return self;
}

- (void) startGame:(SPTouchEvent *) event {
    
    [play removeEventListener:@selector(startGame:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self.stage removeChild:play];
    [self.stage removeChild:imgLoading];
    
    [game play];
}

- (void) finNiveau:(NSNotification *) notification {
    
    if ([startingColor isEqualToString:@"jaune"])
        game = [WorldRed alloc];
    else 
        game = [WorldYellow alloc];

    [game setDelegate:self];
    [game setWidth:320];
    [game setHeight:480];
    
    if (rotate == YES) {
        game.rotation = SP_D2R(90);
        game.x = 320;
    }
    
    [self setUpState:game];
}

@end
