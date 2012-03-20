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
        
        [self setUpTextField:tfBleu = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Arial" fontSize:12 color:0x00dadf] withPosX:10 andPosY:50];
        
        [self setUpTextField:tfRouge = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Arial" fontSize:12 color:0xef2c2c] withPosX:50 andPosY:50];
        
        [self setUpTextField:tfJaune = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Arial" fontSize:12 color:0xfffd00] withPosX:90 andPosY:50];
        
        [self setUpTextField:tfVert = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Arial" fontSize:12 color:0x92d208] withPosX:130 andPosY:50];
        
        [self setUpTextField:tfOrange = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Arial" fontSize:12 color:0xff8400] withPosX:170 andPosY:50];
        
        [self setUpTextField:tfViolet = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Arial" fontSize:12 color:0xa808c8] withPosX:210 andPosY:50];
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
