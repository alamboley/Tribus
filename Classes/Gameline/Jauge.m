//
//  Jauge.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 29/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Jauge.h"

@implementation Jauge


@synthesize niveauBarre;

- (id) initWithColor:(NSString *) worldColor andPourcentage:(int) pourcentage {
    
    if (self = [super init]) {
        
        color = worldColor;
        
        niveauBarre = pourcentage;
        
        jauge = [[SPSprite alloc] init];
        [self addChild:jauge];
        
        SPTexture *originalTexture = [SPTexture textureWithContentsOfFile:[color stringByAppendingString:@"FondJauge.png"]];
        
        fond = [SPImage imageWithTexture:originalTexture];
        fond.pivotX = fond.width / 2;
        fond.pivotY = fond.height / 2;
        if ([color isEqualToString:@"rouge"])
            fond.x = 10;
        [jauge addChild:fond];
        
        SPTextureAtlas *atlas = [SPTextureAtlas atlasWithContentsOfFile:[color stringByAppendingString:@"Jauge.xml"]];
        jaugeAnim = [[SPMovieClip alloc] initWithFrames:[atlas texturesStartingWith:color] fps:25];
        jaugeAnim.pivotX = jaugeAnim.width / 2;
        jaugeAnim.pivotY = jaugeAnim.height / 2;
        [jauge addChild:jaugeAnim];
        [[SPStage mainStage].juggler addObject:jaugeAnim];
        
        SPTexture *textureFondFake = [SPTexture textureWithRegion:[SPRectangle rectangleWithX:0  y:0 width:fond.width height:fond.height - 50] ofTexture:originalTexture];
        
        fondFake = [SPImage imageWithTexture:textureFondFake];
        fondFake.pivotX = fondFake.width / 2;
        if ([color isEqualToString:@"rouge"])
            fondFake.x = 7;
        fondFake.y = -fond.height / 2;
        [jauge addChild:fondFake];
        
        atlas = [SPTextureAtlas atlasWithContentsOfFile:[color stringByAppendingString:@"ParticulesJauge.xml"]];
        jaugeParticle = [[SPMovieClip alloc] initWithFrames:[atlas texturesStartingWith:color] fps:25];
        jaugeParticle.pivotX = jaugeParticle.width / 2;
        jaugeParticle.pivotY = jaugeParticle.height / 2;
        jaugeParticle.x = 1.5;
        
        if (niveauBarre < 20) {
            jaugeParticle.y = -10;
        } else if (niveauBarre < 40) {
            jaugeParticle.y = -20;
        } else if (niveauBarre < 60) {
            jaugeParticle.y = -30;
        } else {
            jaugeParticle.y = -40;
        }

        [jauge addChild:jaugeParticle];
        [[SPStage mainStage].juggler addObject:jaugeParticle];
    }
    
    return self;
}

- (void) destroy {
    
    [[SPStage mainStage].juggler removeObject:jaugeAnim];
    [[SPStage mainStage].juggler removeObject:jaugeParticle];
    
    [self removeAllChildren];
}

@end
