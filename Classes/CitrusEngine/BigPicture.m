//
//  BigPicture.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 13/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "BigPicture.h"
#import "CitrusEngine.h"

@implementation BigPicture

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andPictures:(NSArray *)pictures {
    
    if (self = [super initWithName:paramName params:params]) {
        
        graphic = [[SPSprite alloc] init];
        [self addChild:graphic];
        
        for (NSString *picture in pictures) {
            
            SPImage *img = [SPImage imageWithContentsOfFile:picture];
            [graphic addChild:img];
            
            img.x = self.x;
            img.y = self.y;
            
            self.x += img.width;
        }
        
    }
    
    return self;
}

@end
