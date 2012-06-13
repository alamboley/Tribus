//
//  Stats.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 13/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stats : NSObject

+ (void) initStats;
+ (void) addParticule;
+ (void) particuleCaptured;
+ (float) pourcentageParticule;

@end
