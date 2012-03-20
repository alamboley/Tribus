//
//  GameState.h
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "State.h"
#import "Couleurs.h"

@interface GameState : State {
    
    float gameWidth;
    
    SPSprite *graphismEcranSoutenance;
    
    Couleurs *couleurs;
}

@property (nonatomic) Couleurs *couleurs;

- (void) touchedFake:(SPTouchEvent *) event;

- (void) colorPicked:(NSNotification *) notification;

@end
