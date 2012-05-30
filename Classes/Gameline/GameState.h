//
//  GameState.h
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "State.h"
#import "AnimationSequence.h"

@interface GameState : State {
    
    float gameWidth;
    
    SPSprite *graphismEcranSoutenance;
    
    AnimationSequence *animEcranNoir;
    
    NSString *worldColor;

}

- (void) colorPicked:(NSNotification *) notification;

@end
