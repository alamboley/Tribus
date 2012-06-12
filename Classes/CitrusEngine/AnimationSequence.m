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
    
    ((SPMovieClip *)[mcSequences objectForKey:animation]).currentFrame = 0;
    [((SPMovieClip *)[mcSequences objectForKey:animation]) play];
    
    previousAnimation = animation;
}

- (SPMovieClip *) getCurrentAnimation {
    
    return ((SPMovieClip *)[mcSequences objectForKey:previousAnimation]);
}

- (void) colorClignote {

    for (NSString *key1 in mcSequences) {
        SPTween *tween1 = [SPTween tweenWithTarget:((SPMovieClip *)[mcSequences objectForKey:key1]) time:0.2];
        [tween1 animateProperty:@"color" targetValue:0x000000];
        [[SPStage mainStage].juggler addObject:tween1];
    }
    
    for (NSString *key2 in mcSequences) {
        SPTween *tween2 = [SPTween tweenWithTarget:((SPMovieClip *)[mcSequences objectForKey:key2]) time:0.2];
        [tween2 animateProperty:@"color" targetValue:0xffffff];
        tween2.delay = 0.3;
        [[SPStage mainStage].juggler addObject:tween2];
    }
    
    for (NSString *key3 in mcSequences) {
        SPTween *tween3 = [SPTween tweenWithTarget:((SPMovieClip *)[mcSequences objectForKey:key3]) time:0.2];
        [tween3 animateProperty:@"color" targetValue:0x000000];
        tween3.delay = 0.6;
        [[SPStage mainStage].juggler addObject:tween3];
    }
    
    for (NSString *key4 in mcSequences) {
        SPTween *tween4 = [SPTween tweenWithTarget:((SPMovieClip *)[mcSequences objectForKey:key4]) time:0.2];
        [tween4 animateProperty:@"color" targetValue:0xffffff];
        tween4.delay = 0.9;
        [[SPStage mainStage].juggler addObject:tween4];
    }
}

- (void) dealloc {
    
    [self removeChild:[mcSequences objectForKey:previousAnimation]];
    [self.stage.juggler removeObject:[mcSequences objectForKey:previousAnimation]];
    
    mcSequences = nil;
    textureAtlas = nil;
}

- (AnimationSequence *) copy {
    
    return [[AnimationSequence alloc] initWithTextureAtlas:textureAtlas andAnimations:animations andFirstAnimation:previousAnimation];
}

@end
