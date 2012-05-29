//
//  Jauge.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 29/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "SPSprite.h"

@interface Jauge : SPSprite {
    
    NSString *color;
    
    int niveauBarre;
    
    SPSprite *jauge;
    SPImage *fond, *fondFake;
    SPMovieClip *jaugeAnim;
    SPMovieClip *jaugeParticle;
}

@property int niveauBarre;

- (id) initWithColor:(NSString *) worldColor;
- (void) destroy;

@end
