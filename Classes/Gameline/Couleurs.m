//
//  Couleurs.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 16/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Couleurs.h"
#import "ColorManager.h"
#import "Color.h"

@implementation Couleurs

- (id) init {
    
    if (self = [super init]) {
        
        graphic = [SPImage imageWithContentsOfFile:@"colors_big.png"];
        [self addChild:graphic];
        
        NSMutableDictionary *color = [ColorManager getColors];
        
        [self setUpTextField:tfJaune = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"TwCenMT-Bold" fontSize:14 color:0x000000] withPosX:-7 andPosY:12 andNumber:[color objectForKey:@"jaune"]];
        
        [self setUpTextField:tfBleu = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"TwCenMT-Bold" fontSize:14 color:0x000000] withPosX:28 andPosY:12 andNumber:[color objectForKey:@"bleu"]];
        
        [self setUpTextField:tfRouge = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"TwCenMT-Bold" fontSize:14 color:0x000000] withPosX:65 andPosY:12 andNumber:[color objectForKey:@"rouge"]];
        
        [self setUpTextField:tfViolet = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"TwCenMT-Bold" fontSize:14 color:0x000000] withPosX:103 andPosY:12 andNumber:[color objectForKey:@"violet"]];
        
        [self setUpTextField:tfVert = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"TwCenMT-Bold" fontSize:14 color:0x000000] withPosX:137 andPosY:12 andNumber:[color objectForKey:@"vert"]];
        
        [self setUpTextField:tfOrange = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"TwCenMT-Bold" fontSize:14 color:0x000000] withPosX:174 andPosY:12 andNumber:[color objectForKey:@"orange"]];
    }
    
    return  self;
}

- (void) destroy {
    
    [self removeAllChildren];
    
    graphic = nil;
}

- (void) setUpTextField:(SPTextField *) tf withPosX:(int) thePosX andPosY:(int) thePosY andNumber:(Color *) colors {

    [tf setVAlign:SPVAlignTop];
    [tf setHAlign:SPHAlignCenter];
    
    [self addChild:tf];
    tf.x = thePosX;
    tf.y = thePosY;
    [tf setText:[NSString stringWithFormat:@"%@", colors.colorValue]];
}

@end
