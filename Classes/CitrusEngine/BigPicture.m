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

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andWorld:(NSString *)world {
    
    if (self = [super initWithName:paramName params:params]) {
        
        worldColor = world;
        
        //chargement PLIST :
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
            
            self.posX += img.width - 2;
        }
        
        index = 0;
        
    }
    
    [self addEventListener:@selector(ready:) atObject:self forType:SP_EVENT_TYPE_ADDED_TO_STAGE];
    
    return self;
}

- (void) ready:(SPEvent*) event  {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNiveauReady" object:nil];
    
    [self removeEventListener:@selector(ready:) atObject:self forType:SP_EVENT_TYPE_ADDED_TO_STAGE];
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
            
            SPDisplayObject *img;
            
            if ([worldColor isEqualToString:@"jaune"]) {
                
                img = [graphic childAtIndex:index];
                index = (index == 5) ? 0 : index + 1;
                
            } else {
                
                img = [graphic childAtIndex:arc4random() % graphic.numChildren];
            }
            
            if ((img.x + img.width + 150) < hero.x) {
                
                img.x = self.posX;
                img.y = self.y;
                
                self.posX += img.width - 2;
            }
        }
    }
}

@end
