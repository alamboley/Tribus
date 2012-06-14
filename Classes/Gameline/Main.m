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
        
        //frameRateTextField.visible = TRUE;
        
        imgLoading = [SPImage imageWithContentsOfFile:@"loading-bg.png"];
        imgLoading.rotation = SP_D2R(90);
        imgLoading.x = 320;
        
        [self.stage addChild:imgLoading];
        
        loading = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"loader2.xml"] andAnimations:[NSArray arrayWithObject:@"loader"] andFirstAnimation:@"loader"];
        loading.x = 0;
        loading.y = 180;
        
        [self.stage addChild:loading];
        
        play = [SPImage imageWithContentsOfFile:@"play-btn.png"];
        play.rotation = SP_D2R(90);
        play.x = 80;
        play.y = 180;
        
        [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(showPlayButton:) userInfo:nil repeats:NO];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNiveau:) name:@"changeNiveau" object:nil];
    
    return self;
}

- (id)initWithWidth:(float)width height:(float)height rotation:(BOOL)rotation andStartingColor:(NSString *) startingColorId {
    
    startingColor = startingColorId;

     if (self = [self initWithWidth:width height:height rotation:rotation]) {
         
     }
    
    return self;
}

- (void) showPlayButton:(NSTimer *) timer {
    
    [self.stage addChild:play];
    
    [play addEventListener:@selector(startGame:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self.stage removeChild:loading];
    loading = nil;
}

- (void) startGame:(SPTouchEvent *) event {
    
    [play removeEventListener:@selector(startGame:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    [self.stage removeChild:play];
    [self.stage removeChild:imgLoading];
    
    [game play];
}

- (void) changeNiveau:(NSNotification *) notification {
    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNiveauReady:) name:@"changeNiveauReady" object:nil];
}

- (void) changeNiveauReady:(NSNotification *) notification {
    [game play];
}

@end
