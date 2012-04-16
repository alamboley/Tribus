//
//  Main.m
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Main.h"

@implementation Main

- (id)initWithWidth:(float)width height:(float)height rotation:(BOOL)rotation {
    
    if (self = [super initWithWidth:width height:height rotation:rotation]) {
        
        game = [GameState alloc];
        [game setDelegate:self];
        [game setWidth:320];
        [game setHeight:480];
        
        if (rotation == YES) {
            game.rotation = SP_D2R(90);
            game.x = 320;
        }
        
        [super setUpState:game];
        
        frameRateTextField.visible = TRUE;
    }
    
    return self;
}


@end
