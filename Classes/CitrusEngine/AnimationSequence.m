//
//  AnimationSequence.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 06/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "AnimationSequence.h"

@implementation AnimationSequence

@synthesize mcSequences, textureAtlas, animations, previousAnimation;

- (id) initWithTextureAtlas:(SPTextureAtlas *)textAtlas andAnimations:(NSArray *)multiAnimations andFirstAnimation:(NSString *)firstAnim {
    
    if (self = [super init]) {
        
        textureAtlas = textAtlas;
        animations = multiAnimations;
        mcSequences = [[NSMutableDictionary alloc] init];
        
        for (NSString *animation in multiAnimations) {
            
            if ([textureAtlas texturesStartingWith:animation].count == 0) {
                NSLog(@"One object doesn't have the %@ animation in its TextureAtlas", animation);
            }
            
            [mcSequences setObject:[[SPMovieClip alloc] initWithFrames:[textureAtlas texturesStartingWith:animation] fps:25] forKey:animation];
        }
        
        [self addChild:[mcSequences objectForKey:firstAnim]];
        [[SPStage mainStage].juggler addObject:[mcSequences objectForKey:firstAnim]];
        
        previousAnimation = firstAnim;
    }
    
    return self;
}

- (void) changeAnimation:(NSString *)animation withLoop:(BOOL)animLoop {
    
    if (!([mcSequences objectForKey:animation])) {

        NSLog(@"One object doesn't have the %@ animation set up in its initial array?", animation);
    }
    
    [self removeChild:[mcSequences objectForKey:previousAnimation]];
    [self.stage.juggler removeObject:[mcSequences objectForKey:previousAnimation]];
    
    [self addChild:[mcSequences objectForKey:animation]];
    [self.stage.juggler addObject:[mcSequences objectForKey:animation]];
    ((SPMovieClip *)[mcSequences objectForKey:animation]).loop = animLoop;
    
    if (animLoop == 0) {
        ((SPMovieClip *)[mcSequences objectForKey:animation]).currentFrame = 0;
        [((SPMovieClip *)[mcSequences objectForKey:animation]) play];
    }
    
    previousAnimation = animation;
}

- (void) dealloc {
    
    [self removeChild:[mcSequences objectForKey:previousAnimation]];
    [self.stage.juggler removeObject:[mcSequences objectForKey:previousAnimation]];
}

- (AnimationSequence *) copy {
    
    return [[AnimationSequence alloc] initWithTextureAtlas:textureAtlas andAnimations:animations andFirstAnimation:previousAnimation];
}

@end
