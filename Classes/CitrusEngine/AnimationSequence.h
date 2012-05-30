//
//  AnimationSequence.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 06/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "SPSprite.h"

@interface AnimationSequence : SPSprite {
    
    NSMutableDictionary *mcSequences;
    
    SPTextureAtlas *textureAtlas;
    NSArray *animations;
    NSString *previousAnimation;
}

@property (nonatomic) NSMutableDictionary *mcSequences;
@property (nonatomic) SPTextureAtlas *textureAtlas;
@property (nonatomic) NSArray *animations;
@property (nonatomic) NSString *previousAnimation;

- (id) initWithTextureAtlas:(SPTextureAtlas *) textAtlas andAnimations:(NSArray *) multiAnimations andFirstAnimation:(NSString *) firstAnim;

- (AnimationSequence *) copy;

- (void) changeAnimation:(NSString *) animation withLoop:(BOOL)animLoop;

@end
