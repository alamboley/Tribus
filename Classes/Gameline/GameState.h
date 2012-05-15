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
    
    NSString *worldColor;
}

@property (nonatomic) Couleurs *couleurs;

- (void) colorPicked:(NSNotification *) notification;

@end
