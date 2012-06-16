//
//  Couleurs.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 16/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Couleurs.h"
#import "ColorManager.h"

@implementation Couleurs

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andGraphic:(SPDisplayObject *)displayObject {
    
    if (self = [super initWithName:paramName params:params andGraphic:displayObject]) {
        
        NSMutableDictionary *color = [ColorManager getColors];
        
        [self setUpTextField:tfJaune = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0x000000] withPosX:-5 andPosY:14 andNumber:(NSNumber *)[color objectForKey:@"jaune"]];
        
        [self setUpTextField:tfBleu = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0x000000] withPosX:30 andPosY:14 andNumber:(NSNumber *)[color objectForKey:@"bleu"]];
        
        [self setUpTextField:tfRouge = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0x000000] withPosX:65 andPosY:14 andNumber:(NSNumber *)[color objectForKey:@"rouge"]];
        
        [self setUpTextField:tfViolet = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0x000000] withPosX:103 andPosY:14 andNumber:(NSNumber *)[color objectForKey:@"violet"]];
        
        [self setUpTextField:tfVert = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0x000000] withPosX:137 andPosY:14 andNumber:(NSNumber *)[color objectForKey:@"vert"]];
        
        [self setUpTextField:tfOrange = [SPTextField textFieldWithWidth:50 height:20 text:@"" fontName:@"Tw Cen MT" fontSize:14 color:0x000000] withPosX:172 andPosY:14 andNumber:(NSNumber *)[color objectForKey:@"orange"]];
    }
    
    return  self;
}

- (void) setUpTextField:(SPTextField *) tf withPosX:(int) thePosX andPosY:(int) thePosY andNumber:(NSNumber *) colors {
    NSLog(@"%@", colors);
    [tf setVAlign:SPVAlignTop];
    [tf setHAlign:SPHAlignCenter];
    
    [self addChild:tf];
    tf.x = thePosX;
    tf.y = thePosY;
    [tf setText:[NSString stringWithFormat:@"%d", colors]];
}

@end
