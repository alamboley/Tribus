//
//  Couleurs.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 20/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hud.h"

@interface Couleurs : NSObject {
    
    int rouge, bleu, jaune, orange, vert, violet;
    
    int gains;
    
    Hud *ui;
}

@property (nonatomic) Hud *ui;

- (id) initWithRouge:(int) red andBleu:(int) blue andJaune:(int) yellow andOrange:(int) oran andVert:(int) green andViolet:(int) vio;

- (void) refreshScore;

- (void) addColor:(NSString *) color;

- (void) piegeColor:(NSString *) color;

- (void) filtreDissociatif:(NSString *) color1 andColor2:(NSString *) color2;

- (void) filtreAssociatif:(NSString *) color;

@end
