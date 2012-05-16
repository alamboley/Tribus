
//
//  FiltreDissociatif.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 16/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "FiltreDissociatif.h"

@implementation FiltreDissociatif

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject andColor:(NSString *) worldColor {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        color = worldColor;
        
        //[(AnimationSequence *)graphic changeAnimation:animation withLoop:loopAnimation];
        
        SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:@"filtreDissociatifVert.xml"];
        
        //atlas 
        
        //[(SPMovieClip *)graphic addFrame:<#(SPTexture *)#> ]
        //graphic = [[SPMovieClip alloc] initWithFrames:[atlas texturesStartingWith:@""] fps:25];
        
        //[[SPStage mainStage].juggler addObject:mc];
    }
    
    return self;
}

- (void) destroy {
    
    //[[SPStage mainStage].juggler removeObject:mc];
}

@end
