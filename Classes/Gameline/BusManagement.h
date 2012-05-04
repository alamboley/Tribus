//
//  BusManagement.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 04/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hero.h"

@interface BusManagement : NSObject {
    
    Hero *hero;
    
    NSArray* travel;
    
    NSTimer *timer;
    
    int indice;
}

- (id) initWithData:(NSString *) pathForResource andHero:(Hero *) heroParam;

- (void) start;
- (void) stop;

@end
