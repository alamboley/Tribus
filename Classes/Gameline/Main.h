//
//  Main.h
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CitrusEngine.h"
#import "GameState.h"

@interface Main : CitrusEngine {
    
    GameState *game;
    BOOL rotate;
    NSString *startingColor;
    
    SPImage *imgLoading;
    SPImage *play;
}

- (id)initWithWidth:(float)width height:(float)height rotation:(BOOL)rotation andStartingColor:(NSString *) startingColorId;

@end
