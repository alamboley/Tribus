//
//  Couleurs.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 20/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Couleurs.h"
#import "CitrusEngine.h"

@implementation Couleurs

@synthesize ui;

- (id) initWithRouge:(int) red andBleu:(int) blue andJaune:(int) yellow andOrange:(int) oran andVert:(int) green andViolet:(int) vio {
    
    if (self = [super init]) {
        
        rouge = red;
        bleu = blue;
        jaune = yellow;
        orange = oran;
        vert = green;
        violet = vio;
        
        gains = 10;
        
        ui = [CitrusEngine getInstance].state.ui;
        
        [self refreshScore];
        
        /*
         Rouge = Orange - Jaune = Violet - Bleu
         Bleu = Vert - Jaune = Violet -Rouge
         Jaune = Orange - Rouge = Vert - Bleu
         Orange = Rouge + Jaune
         Vert = Jaune + Bleu
         Violet = Bleu + Rouge
         */
    }
    
    return self;
}

- (void) addColor:(NSString *) color {

    if ([color isEqualToString:@"jaune"]) {
        
        jaune += gains;
    }
    
    if ([color isEqualToString:@"rouge"]) {
        
        rouge += gains;
    }
    
    [self refreshScore];
}

- (void) piegeColor:(NSString *) color {
    
    if ([color isEqualToString:@"jaune"]) {
        
        jaune -= 50;
    }
    
    if ([color isEqualToString:@"rouge"]) {
        
        rouge -= 50;
    }
    
    [self refreshScore];
}


- (void) filtreAssociatif:(NSString *) color {
    
    if ([color isEqualToString:@"colorVert"]) {
        
        jaune -= 10;
        bleu -= 10;
        vert += 20;
    }
    
    [self refreshScore];
}

- (void) filtreDissociatif:(NSString *)color1 andColor2:(NSString *)color2 {
    
    if (([color1 isEqualToString:@"colorOrange"] && [color2 isEqualToString:@"colorJaune"]) || ([color2 isEqualToString:@"colorOrange"] && [color1 isEqualToString:@"colorJaune"])) {
        
        orange -= 10;
        jaune -= 10;
        rouge += 20;
    }

    [self refreshScore];
}

- (void) refreshScore {
    
    [ui.tfRouge setText:[NSString stringWithFormat:@"%d", rouge]];
    [ui.tfBleu setText:[NSString stringWithFormat:@"%d", bleu]];
    [ui.tfJaune setText:[NSString stringWithFormat:@"%d", jaune]];
    [ui.tfOrange setText:[NSString stringWithFormat:@"%d", orange]];
    [ui.tfVert setText:[NSString stringWithFormat:@"%d", vert]];
    [ui.tfViolet setText:[NSString stringWithFormat:@"%d", violet]];
}

@end
