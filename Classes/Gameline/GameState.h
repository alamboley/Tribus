//
// GameState.h
// Gameline
//
// Created by Aymeric Lamboley on 24/02/12.
// Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "State.h"
#import "AnimationSequence.h"
#import "Hero.h"
#import "BusManagement.h"
#import "CreationRuntime.h"

@interface GameState : State {
    
    float gameWidth;
    
    SPSprite *ecranFumeeContainer;
    
    SPImage *autoDrive;
    
    AnimationSequence *animEcranNoir;
    AnimationSequence *animHero;
    
    NSString *worldColor;
    
    Hero *hero;
    BusManagement *bus;
    CreationRuntime *creationRuntime;
}

- (void) play;

- (void) colorPicked:(NSNotification *) notification;

- (void) finNiveau:(NSNotification *) notification;

@end