//
//  BigPicture.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 13/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "BigPicture.h"
#import "CitrusEngine.h"

@implementation BigPicture

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andWorld:(NSString *)world; {
    
    if (self = [super initWithName:paramName params:params]) {
        
        //chargement XML :
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistChemin = [bundle pathForResource:@"DonneesAleatoires" ofType:@"plist"];
        NSDictionary *dictionnaire = [[NSDictionary alloc] initWithContentsOfFile:plistChemin];
        NSArray *niveauUn = [NSArray arrayWithObject:[dictionnaire valueForKey:@"Root"]];
        
        niveauUn = [niveauUn valueForKey:world];
        
        NSArray *imgWorld = [NSArray arrayWithArray:[niveauUn objectAtIndex:0]];
        
        graphic = [[SPSprite alloc] init];
        [self addChild:graphic];
        
        for (NSString *picture in imgWorld) {
            
            SPImage *img = [SPImage imageWithContentsOfFile:picture];
            [graphic addChild:img];
            
            img.x = self.posX;
            img.y = self.y;

            self.posX += img.width;
        }
        
    }
    
    return self;
}

- (void) destroy {
    
    [graphic removeAllChildren];
    
    [super destroy];
}

- (void) update {
    
    [super update];
    
    if (!hero) {
        
        hero = [ce.state getObjectByName:@"hero"];
        
    } else {

        if (hero.x > self.width - 480 - 150) {
            
            SPDisplayObject *img = [graphic childAtIndex:arc4random() % graphic.numChildren];
            
            if ((img.x + img.width + 50) < hero.x) {

                img.x = self.posX;
                img.y = self.y;

                self.posX += img.width;
            }
        }
    }
}

@end
