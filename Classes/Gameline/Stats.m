//
//  Stats.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 13/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Stats.h"

@implementation Stats

static float nbrParticules = 0;
static float nbrParticulesCaptured = 0;

+ (void) initStats {
    
    nbrParticules = 0;
    nbrParticulesCaptured = 0;
}

+ (void) addParticule {
    
    nbrParticules++;
}

+ (void) particuleCaptured {
    
    nbrParticulesCaptured++;
}

+ (float) pourcentageParticule {
    
    return (nbrParticulesCaptured / nbrParticules * 100);
}

@end
