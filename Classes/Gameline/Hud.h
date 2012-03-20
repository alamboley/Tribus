//
//  Hud.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 20/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "SPSprite.h"

@interface Hud : SPSprite {
    
    SPTextField *tfBleu, *tfRouge, *tfJaune, *tfVert, *tfOrange, *tfViolet;
}

@property (nonatomic) SPTextField *tfBleu, *tfRouge, *tfJaune, *tfVert, *tfOrange, *tfViolet;

- (id) init;

- (void) setUpTextField:(SPTextField *) tf withPosX:(int) posX andPosY:(int) posY;

@end
