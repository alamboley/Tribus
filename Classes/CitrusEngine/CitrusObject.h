//
//  CitrusObject.h
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CitrusEngine;

@interface CitrusObject : SPSprite {
    
    CitrusEngine *ce;
    NSString *name;
    SPSprite *graphic;
    
    int group;
    float posX;
    float posY;
    float widthBody;
    float heightBody;
    float parallax;
    BOOL kill;
}

@property (nonatomic) CitrusEngine *ce;
@property (nonatomic) NSString *name;
@property (nonatomic) SPDisplayObject *graphic;
@property int group;
@property float parallax;
@property BOOL kill;
@property float posX, posY;

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params;
- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject;

- (void) update;
- (void) destroy;

- (void) x:(NSString *) value;
- (void) y:(NSString *) value;
- (void) rotation:(NSString *) value;
- (void) width:(NSString *) value;
- (void) height:(NSString *) value;
- (void) parallax:(NSString *) value;
- (void) group:(NSString *) value;

@end
