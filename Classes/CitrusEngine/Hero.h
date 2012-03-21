//
//  Hero.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 05/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "PhysicsObject.h"

@interface Hero : PhysicsObject {
    
    NSString *animation;
    BOOL loopAnimation;
    
    BOOL isOnGround;
    
    CMShape *sensorOnGround;
    
    float jumpHeight, jumpAcceleration, jumpDeceleration;
    float velocityX, velocityY;
    
    BOOL touchScreen;
}

@property (nonatomic) NSString *animation;
@property (nonatomic) CMShape *sensorOnGround;

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject;
- (void) simpleInit;

@end
