//
//  Hud.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 20/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Hud.h"

@implementation Hud

@synthesize tfBleu, tfRouge, tfJaune, tfVert, tfOrange, tfViolet;

- (id) init {
    
    if (self = [super init]) {
        
        SPImage *imgFond = [SPImage imageWithContentsOfFile:@"pigments-ingame.png"];
        imgFond.x = 3;
        imgFond.y = 3;
        
        [self addChild:imgFond];
        
        [self setUpTextField:tfBleu = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0xFFFFFF] withPosX:-5 andPosY:14];
        
        [self setUpTextField:tfRouge = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0xFFFFFF] withPosX:30 andPosY:14];

        [self setUpTextField:tfJaune = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0xFFFFFF] withPosX:65 andPosY:14];
        
        [self setUpTextField:tfVert = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0xFFFFFF] withPosX:103 andPosY:14];
        
        [self setUpTextField:tfOrange = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0xFFFFFF] withPosX:137 andPosY:14];
        
        [self setUpTextField:tfViolet = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0xFFFFFF] withPosX:172 andPosY:14];
    }
    
    return self;
}

- (void) setUpTextField:(SPTextField *) tf withPosX:(int) posX andPosY:(int) posY {
    
    [tf setVAlign:SPVAlignTop];
    [tf setHAlign:SPHAlignCenter];
    
    [self addChild:tf];
    tf.x = posX;
    tf.y = posY;
}

@end
