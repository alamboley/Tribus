//
//  BusManagement.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 04/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CitrusEngine.h"
#import "CitrusObject.h"
#import "Hero.h"
#import "AnimationSequence.h"

@interface BusManagement : NSObject {
    
    CitrusEngine *ce;
    
    NSString *worldColor;
    
    Hero *hero;
    
    NSArray *travel;
    
    NSDate *startTime;
    NSTimer *timer;
    
    int indice;
    
    BOOL creerEnnemis;
    
    AnimationSequence *animTaedioAspire;
    AnimationSequence *animTaedioFumee;
}

@property (nonatomic) BOOL creerEnnemis;

- (id) initWithData:(NSString *) pathForResource andHero:(Hero *) heroParam andColor:(NSString *)color;

- (void) destroy;

- (void) start;
- (void) stop;

- (void) creerEnnemi;

@end
