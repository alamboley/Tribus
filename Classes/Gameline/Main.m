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
        
        game = [WorldYellow alloc];
        [game setDelegate:self];
        [game setWidth:320];
        [game setHeight:480];
        
        if (rotate == YES) {
            game.rotation = SP_D2R(90);
            game.x = 320;
        }
        
        [super setUpState:game];
        
        frameRateTextField.visible = TRUE;
    }
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finNiveau:) name:@"finNiveau" object:nil];
    
    return self;
}

- (void) finNiveau:(NSNotification *) notification {
    
    
    game = [WorldRed alloc];
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
