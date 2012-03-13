//
//  CarreFlash.m
//  Gameline
//
//  Created by Aymeric Lamboley on 15/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CarreFlash.h"

@implementation CarreFlash

- (id)init {
    
    if (self = [super init]) {
        
        SPImage *ballImage = [SPImage imageWithContentsOfFile:@"flash.png"];
        [ballImage setX:-[ballImage width] / 2.0f];
        [ballImage setY:-[ballImage height] / 2.0f];
        [self addChild:ballImage];
    }
    
    return self;
}


@end
