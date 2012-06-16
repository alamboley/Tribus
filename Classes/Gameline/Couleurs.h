//
//  Couleurs.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 16/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CitrusObject.h"

@interface Couleurs : SPSprite {

    SPImage *graphic;
    SPTextField *tfBleu, *tfRouge, *tfJaune, *tfVert, *tfOrange, *tfViolet;
}
- (void) destroy;

@end
