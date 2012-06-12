//
//  WorldYellow.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 01/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GameState.h"
#import "Jauge.h"
#import "AnimationSequence.h"

@interface WorldYellow : GameState {
    
    SPImage *imgArrivee;
    
    Jauge *jauge;
    AnimationSequence *portalRed;
    
    SPImage *pouvoir;
}

@end
