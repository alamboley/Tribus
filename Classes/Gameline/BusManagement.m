//
//  BusManagement.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 04/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "BusManagement.h"
#import "SBJsonParser.h"
#import "TaedioAspire.h"
#import "TaedioFumee.h"

@implementation BusManagement
@synthesize creerEnnemis;

- (id) initWithData:(NSString *) pathForResource andHero:(Hero *) heroParam andColor:(NSString *)color {
    
    if (self = [super init]) {
        
        worldColor = color;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:pathForResource ofType:@"json"];
        NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *jsonString = [[NSString alloc] initWithString:fileContent];
        
        NSDictionary *status = [parser objectWithString:jsonString];
        travel = [status objectForKey:@"travel"];
        
        ce = [CitrusEngine getInstance];
        
        hero = heroParam;
        
        indice = 0;
        
        creerEnnemis = YES;
        
        animTaedioAspire = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"taedioAspire.xml"] andAnimations:[NSArray arrayWithObjects:@"taedioAspire", @"taedioBase", nil] andFirstAnimation:@"taedioBase"];
        
        animTaedioFumee = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"taedioFumee.xml"] andAnimations:[NSArray arrayWithObjects:@"taedioFumee", nil] andFirstAnimation:@"taedioFumee"];
    }
    
    return self;
}

- (void) destroy {
    
        animTaedioAspire = nil;
        animTaedioFumee = nil;
}

- (void) start {
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
    
    startTime = [[NSDate alloc] init];
}

- (void) stop {
    
    [timer invalidate];
    timer = nil;
}

- (void) onTick:(NSTimer *) timer {
    
    NSDictionary *travelFirstElement = [travel objectAtIndex:indice];
    travelFirstElement = [travelFirstElement objectForKey:@"coords"];
    
    NSDictionary *arretBus = [travel objectAtIndex:indice];
    
    NSDictionary *arretBusEnAvance = [travel objectAtIndex:indice + 5];   
    
    if ([[arretBus objectForKey:@"type"] isEqualToString:@"abribus"]) {
        
        [self stop];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"finNiveau" object:nil];
    }
    
    if ([[arretBusEnAvance objectForKey:@"type"] isEqualToString:@"abribus"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"prochainArret" object:nil];
    }
    
    if (35 + 12 * [[travelFirstElement objectForKey:@"speed"]floatValue] - hero.velocityX < 0) {
        
        [self creerEnnemi];
    }
    
    SPTween *tween = [SPTween tweenWithTarget:hero time:2.0f];
    [tween animateProperty:@"velocityX" targetValue:35 + 12 * [[travelFirstElement objectForKey:@"speed"]floatValue]];
    [[SPStage mainStage].juggler addObject:tween];
    
    indice = (indice >= travel.count) ? 0 : indice + 1;
}

- (void) creerEnnemi {
    
    if (creerEnnemis) {
        
        float positionX = hero.x + 500 + arc4random() % 300;
        float positionY = 50 + arc4random() % 250;
        
        if (arc4random() % 2 > 0) {
            
            if ([worldColor isEqualToString:@"jaune"] && [startTime timeIntervalSinceNow] < -60) {
                
                TaedioFumee *taedioFumee = [[TaedioFumee alloc] initWithName:@"taedioFumee" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"120", @"60", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[animTaedioFumee copy]];
                [ce.state addObject:taedioFumee];
                
            } else if ([worldColor isEqualToString:@"rouge"]) {
                
                positionY = 270;
                
                TaedioAspire *taedioAspire = [[TaedioAspire alloc] initWithName:@"taedioAspire" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", positionX], [NSString stringWithFormat:@"%f", positionY], @"60", @"80", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", nil]] andGraphic:[animTaedioAspire copy]];
                [ce.state addObject:taedioAspire];
            }
            
        }
    }
}

@end
