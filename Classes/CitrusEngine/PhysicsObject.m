//
//  PhysicsObject.m
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "PhysicsObject.h"
#import "CitrusEngine.h"

@implementation PhysicsObject

@synthesize space, body, shape;
@synthesize isStatic;

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super initWithName:paramName params:params]) {
        
        space = ce.state.space;
        
        [self createBody];
        [self defineBody];
        
        [self createShape];
        [self defineShape];
    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        space = ce.state.space;
        
        displayObject.pivotX = displayObject.width / 2;
        displayObject.pivotY = displayObject.height / 2;
        
        [self createBody];
        [self defineBody];
        
        [self createShape];
        [self defineShape];
    }
    
    return self;
}

- (void) update {
    
    [super update];
}

- (void) destroy {
    
    [super destroy];
    
    [body removeShape:shape];
    [body removeFromSpace];
    shape = nil;
    body = nil;
}

- (void) isStatic:(BOOL) staticBody {
    
    isStatic = staticBody;
}

- (void) createBody {
    
    if (isStatic == 0) {
        
        body = [space addBodyWithMass:5.0 moment:INFINITY];
        [body addToSpace];
        
    } else {
        
        body = [space addStaticBody];
    }
    
}

- (void) defineBody {
    
    [body setAngle:self.rotation];
    [body setPositionUsingVect:cpv(self.x, self.y)];
    
    [body setData:self];
    
    if (self.graphic && isStatic == 0) {
        
        graphic.x = 0;
        graphic.y = 0;
    }
    
}

- (void) createShape {
    
    shape = [body addRectangleWithWidth:widthBody height:heightBody];
    
    [shape addToSpace];
}

- (void) defineShape {
    
    [shape setElasticity:0.7];
    [shape setFriction:0.7];
}



@end
