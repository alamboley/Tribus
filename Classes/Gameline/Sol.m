//
//  Sol.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 20/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Sol.h"

@implementation Sol

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params {
    
    if (self = [super initWithName:paramName params:params]) {
        
        SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:@"sol.xml"];
        
        graphic = [[SPSprite alloc] init];
        [self addChild:graphic];
        
        while (graphic.width < widthBody) {
            
            int random = arc4random() % 6 + 1;

            SPTexture *texture = [atlas textureByName:[NSString stringWithFormat:@"%@%d", @"sol", random]];
            
            SPImage *img = [SPImage imageWithTexture:texture];
            [graphic addChild:img];
            
            img.x = self.x;
            img.y = posY;
            
            self.x += img.width;
        }
        
    }
    
    return self;
}

@end
