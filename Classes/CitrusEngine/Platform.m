//
//  Platform.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 05/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Platform.h"

@implementation Platform

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super initWithName:paramName params:params]) {

    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {

    }
    
    return self;
}

- (void) defineShape {
    
    [shape setElasticity:0.5];
    [shape setFriction:0];
    [shape setCollisionType:@"platform"];
}

@end
