//
//  Main.m
//  Gameline
//
//  Created by Aymeric Lamboley on 24/02/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "Main.h"

@implementation Main

- (id)initWithWidth:(float)width height:(float)height rotation:(BOOL)rotation {
    
    if (self = [super initWithWidth:width height:height rotation:rotation]) {
        
        game = [GameState alloc];
        [game setDelegate:self];
        [game setWidth:320];
        [game setHeight:480];
        
        if (rotation == YES) {
            game.rotation = SP_D2R(90);
            game.x = 320;
        }
        
        [self graphismSoutenance:[NSArray arrayWithObjects:@"attente.png", @"pagechoixile.png", nil]];
        
        //[self showGame];
        
        //frameRateTextField.visible = TRUE;
    }
    
    return self;
}

- (void) graphismSoutenance:(NSArray *) pictures {
    
    graphismEcranSoutenance =  [[SPSprite alloc] init];
    graphismEcranSoutenance.x = 0;
    graphismEcranSoutenance.y = 0;
    
    for (NSString *picture in pictures) {
        
        SPImage *img = [SPImage imageWithContentsOfFile:picture];
        [graphismEcranSoutenance addChild:img];
        
        img.x = graphismEcranSoutenance.x;
        img.y = graphismEcranSoutenance.y;
        
        graphismEcranSoutenance.x += img.width;
    }
    
    [self.stage addChild:graphismEcranSoutenance];
    
    graphismEcranSoutenance.rotation = SP_D2R(90);
    graphismEcranSoutenance.x = 320;
    
        canSlideSoutenance = YES;
    
    [graphismEcranSoutenance addEventListener:@selector(touchedFake:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void) touchedFake:(SPTouchEvent *) event {
    
    SPTouch *begin = [[event touchesWithTarget:graphismEcranSoutenance andPhase:SPTouchPhaseBegan] anyObject];
    
    if (begin) {
        
        if (canSlideSoutenance == 1) {
            
            SPTween *tween = [SPTween tweenWithTarget:graphismEcranSoutenance time:0.7f];
            [tween animateProperty:@"y" targetValue:graphismEcranSoutenance.y - 480];
            [tween addEventListener:@selector(onTweenCompleted:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
            [self.stage.juggler addObject:tween];
            
            canSlideSoutenance = NO;
        }
    }
    
}

- (void) onTweenCompleted:(SPEvent *) event {
    
    canSlideSoutenance = YES;
    
    if (graphismEcranSoutenance.y == -960) {
            [self showGame];
    }
}

- (void) showGame {
    
    [super setUpState:game];
}


@end
