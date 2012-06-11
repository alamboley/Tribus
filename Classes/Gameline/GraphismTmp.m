//
//  GraphismTmp.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 15/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GraphismTmp.h"
#import "CitrusEngine.h"

@implementation GraphismTmp

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

- (void) destroy {
    
    [super destroy];
}

- (void) update {
    
    [super update];
    
    if (!hero) {
        
        hero = [ce.state getObjectByName:@"hero"];
        
    } else {
        
        if (hero.x - hero.width > (self.posX * self.parallax) + 50) {
            self.kill = YES;
        }
    }
}


@end
