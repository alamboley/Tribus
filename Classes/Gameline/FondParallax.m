//
//  FondParallax.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 01/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "FondParallax.h"
#import "CitrusEngine.h"

@implementation FondParallax

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andWorld:(NSString *)world {
    
    if (self = [super initWithName:paramName params:params]) {
        
        graphic = [[SPSprite alloc] init];
        [self addChild:graphic];
        
        
        for (int i = 0; i < 2; ++i) {
            
            SPImage *img = [SPImage imageWithContentsOfFile:[world stringByAppendingString:@"_fond.png"]];
            [graphic addChild:img];
            
            img.x = self.posX;
            img.y = self.y;
            
            self.posX += img.width;
        }
        
        index = 0;
    }
    
    return self;
}

- (void) destroy {
    
    [graphic removeAllChildren];
    
    [super destroy];
}

- (void) update {
    
    [super update];
    
    if (!hero) {
        
        hero = [ce.state getObjectByName:@"hero"];
        
    } else {
        
        if (hero.x > self.width - 480 - 150) {
            
            NSLog(@"ici");
            
            SPDisplayObject *img = [graphic childAtIndex:index];
            
            if ((img.x + img.width + 50) < hero.x) {
                
                img.x = self.posX;
                img.y = self.y;
                
                self.posX += img.width - 2;
            }
            
            index = (index == 0) ? 1 : 0;
        }
    }
}

@end
