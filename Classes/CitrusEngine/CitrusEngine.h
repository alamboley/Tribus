//
//  CitrusEngine.h
//  Gameline
//
//  Created by Aymeric Lamboley on 21/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "State.h"

@interface CitrusEngine : SPStage {
    
    SPTextField *frameRateTextField;
    
    State *state;
    State *aNewState;
}

@property (nonatomic) State *state;
@property (nonatomic) State *aNewState;
@property (nonatomic) SPTextField *frameRateTextField;

+ (CitrusEngine *) getInstance;

- (id)initWithWidth:(float)width height:(float)height rotation:(BOOL)rotation;

- (void) setUpState:(State *)theNewState;

- (void) destroy;

@end
