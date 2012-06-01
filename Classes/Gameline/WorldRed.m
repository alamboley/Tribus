//
//  WorldRed.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 01/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "WorldRed.h"

@implementation WorldRed

- (id) init {
    
    worldColor = @"rouge";
    
	if (self = [super init]) {
        
    }
    
    return self;
}

- (void) destroy {
    
    [super destroy];
}

@end
