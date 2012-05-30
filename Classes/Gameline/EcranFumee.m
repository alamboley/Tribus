//
//  EcranFumee.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "EcranFumee.h"

@implementation EcranFumee

- (id) initWithXML:(NSString *) atlasXML {
    
    if (self = [super init]) {
        
        
        AnimationSequence *animEcranNoir = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:atlasXML] andAnimations:[NSArray arrayWithObjects:@"noirDisparition", @"noirExplosion", nil] andFirstAnimation:@"noirExplosion"];
        
        animEcranNoir.scaleX = 2;
        animEcranNoir.scaleY = 2;
        
        animEcranNoir.rotation = SP_D2R(90);
        
        animEcranNoir.x = 320;
        animEcranNoir.y = 0;
        
        [animEcranNoir changeAnimation:@"noirExplosion" withLoop:NO];
        
        [self addChild:animEcranNoir];
        
        
        [self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    }
    
    return self;
}

- (void)onTouch:(SPTouchEvent*)event
{
    SPTouch *touch = [[event touchesWithTarget:self andPhase:SPTouchPhaseBegan] anyObject];
    if (touch)
    {
        SPPoint *touchPosition = [touch locationInSpace:self];
        NSLog(@"Touched position (%f, %f)",
              touchPosition.x, touchPosition.y);
    }
}

@end
