//
//  PhysicsObject.h
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CitrusObject.h"

@interface PhysicsObject : CitrusObject {
    
    CMSpace *space;
    CMBody *body;
    CMShape *shape;
    
    BOOL isStatic;
}

@property (nonatomic) CMSpace *space;
@property (nonatomic) CMBody *body;
@property (nonatomic) CMShape *shape;

@property BOOL isStatic;

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject;

- (void) isStatic:(BOOL) staticBody;

- (void) createBody;
- (void) defineBody;

- (void) createShape;
- (void) defineShape;


@end