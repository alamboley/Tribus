//
//  CitrusObject.m
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CitrusObject.h"
#import "CitrusEngine.h"

@interface CitrusObject ()

- (void) setParams:(NSDictionary *) object;

@end

@implementation CitrusObject

@synthesize ce, name, graphic;
@synthesize group, parallax;
@synthesize kill;

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super init]) {
        
        ce = [CitrusEngine getInstance];
        
        self.name = paramName;
        [self setParams:params];
    }
    
    return self;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPSprite *)displayObject {
    
    if (self = [super init]) {
        
        ce = [CitrusEngine getInstance];
        
        self.name = paramName;
        [self setParams:params];        
        
        graphic = displayObject;
        [self addChild:graphic];
        
        graphic.x = self.x;
        graphic.y = self.y;
        //graphic.rotation = self.rotation;
        
        //can't modif the size of the graphic after its creation
        //self.width = graphic.width;
        //self.height = graphic.height;
    }

    return self;
}

- (void) update {
    
    if (parallax && graphic) {
    
        self.graphic.x = self.x - ce.state.y * (1 - self.parallax);
    }
}

- (void) destroy {
    
    if (graphic != nil) {
        [self removeChild:graphic];
    }
    
}

- (void) setParams:(NSDictionary *) object {

    for (NSString *param in object) {
        
        @try {

            SEL selector = NSSelectorFromString(param);
            [self performSelector: selector withObject:[object objectForKey:param]];
        }
        @catch (NSException *exception) {
            NSLog(@"le param : %@ n'existe pas %@", param, exception);
        }
        
    }
}

- (void) x:(NSString *) value {
    
    self.x = [value floatValue];
}

- (void) y:(NSString *) value {
    
    self.y = [value floatValue];
}

- (void) rotation:(NSString *) value {
    
    self.rotation = SP_D2R([value floatValue]);
}

- (void) parallax:(NSString *)value {
    
    self.parallax = [value floatValue];
}

- (void) group:(NSString *) value {
    
    self.group = [value intValue];
}

/** 
 * Width & height ne marchent pas si pas de graph associé, donc utilisation de widthBody & heightBody
 * requiert une valeur plutôt grande.
 **/
- (void) width:(NSString *) value {

    widthBody = [value floatValue];
}

- (void) height:(NSString *) value {
    
    heightBody = [value floatValue];
}

@end
