//
//  BusManagement.m
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 04/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "BusManagement.h"
#import "SBJsonParser.h"

@implementation BusManagement

- (id) initWithData:(NSString *) pathForResource andHero:(Hero *) heroParam {
    
    if (self = [super init]) {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:pathForResource ofType:@"json"];
        NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSString *jsonString = [[NSString alloc] initWithString:fileContent];
        
        NSDictionary *status = [parser objectWithString:jsonString];
        travel = [status objectForKey:@"travel"];
        
        hero = heroParam;
        
        indice = 0;
    }
    
    return self;
}

- (void) start {
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
}

- (void) stop {
    
    [timer invalidate];
    timer = nil;
}

- (void) onTick:(NSTimer *) timer {
    
    NSDictionary *travelFirstElement = [travel objectAtIndex:indice];
    travelFirstElement = [travelFirstElement objectForKey:@"coords"];
    
    SPTween *tween = [SPTween tweenWithTarget:hero time:2.0f];
    [tween animateProperty:@"velocityX" targetValue:30 + 15 * [[travelFirstElement objectForKey:@"speed"]floatValue]];
    [[SPStage mainStage].juggler addObject:tween];
    
    indice = (indice >= travel.count) ? 0 : indice + 1;
    
    NSLog(@"%f %f", hero.velocityX, [[travelFirstElement objectForKey:@"speed"]floatValue]);
}

@end
