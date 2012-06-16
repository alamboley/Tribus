//
//  WorldRed.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 01/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GameState.h"
#import "PouvoirExchange.h"

@interface WorldRed : GameState {
    
    SPImage *imgArrivee;
    NSTimer *timerRecupPouvoir;
    
    PouvoirExchange *pouvoirExchange;
    SPImage *pouvoir;
    
    SPImage *btnSuivant;
}

@end
