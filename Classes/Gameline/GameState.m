//
// GameState.m
// Gameline
//
// Created by Aymeric Lamboley on 24/02/12.
// Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "GameState.h"
#import "CitrusObject.h"
#import "Platform.h"
#import "BigPicture.h"
#import "Sensor.h"
#import "Sol.h"
#import "ColorManager.h"
#import "EcranFumee.h"
#import "PouvoirExchange.h"
#import "Stats.h"

@implementation GameState

- (id) init {
    
    if (self = [super init]) {
        
        //[USave saveItemId:[obj objectForKey:@"id"] forType:self.title];
        
        gameWidth = 500680;
        
        [self showHideDebugDraw];
        [self showHideDebugDraw];
        
        CitrusObject *parallaxe1 = [[CitrusObject alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", @"0.027", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"parallax:", nil]] andGraphic:[SPImage imageWithContentsOfFile:[worldColor stringByAppendingString:@"_fond.png"]]];
        [self addObject:parallaxe1];
        
        BigPicture *parallaxe2 = [[BigPicture alloc] initWithName:@"bg" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0", @"0", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", nil]] andWorld:worldColor];
        [self addObject:parallaxe2];
        
        Platform *platformBot = [[Platform alloc] initWithName:@"platform" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%f", gameWidth / 2], @"315", [NSString stringWithFormat:@"%f", gameWidth], @"10", @"TRUE", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"isStatic:", nil]]];
        [self addObject:platformBot];
        
        animEcranNoir = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"ecranNoir.xml"] andAnimations:[NSArray arrayWithObjects:@"noirDisparition", @"noirExplosion", nil] andFirstAnimation:@"noirExplosion"];
        
        scoreEnHaut = [[Couleurs alloc] init];
        
        ecranFumeeContainer = [[SPSprite alloc] init];
        [self.stage addChild:ecranFumeeContainer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finNiveau:) name:@"finNiveau" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(arretProche:) name:@"arretProche" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"jaune" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"rouge" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"piege" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"filtreDissociatif" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorPicked:) name:@"filtreAssociatif" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baddyManagement:) name:@"ecranFumee" object:nil];
    }
    
    return self;
}

- (void) play {
    
    autoDrive = [SPImage imageWithContentsOfFile:@"bouton-pause.png"];
    [autoDrive addEventListener:@selector(onAutoDriveTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    [self.stage addChild:autoDrive];
    autoDrive.rotation = SP_D2R(90);
    autoDrive.x = 315;
    autoDrive.y = 425;
    
    hero = [[Hero alloc] initWithName:@"hero" params:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"20", @"150", @"40", @"80", @"2", nil] forKeys:[NSArray arrayWithObjects:@"x:", @"y:", @"width:", @"height:", @"group:", nil]] andGraphic:animHero];
    [self addObject:hero];
    
    bus = [[BusManagement alloc] initWithData:@"DonneesBus" andHero:hero andColor:worldColor];
    [bus start];
    
    creationRuntime = [[CreationRuntime alloc] initWithWorld:worldColor];
    [creationRuntime start];
    
    [self setupCamera:hero andOffset:CGPointMake(hero.width / 2 - 80, 0) andBounds:CGRectMake(0, 0, gameWidth, 1000) andEasing:CGPointMake(0.25, 0.05)];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stageReady:) userInfo:nil repeats:NO];
}

- (void) stageReady:(NSTimer *) timer {

    [self.stage addChild:scoreEnHaut];
    scoreEnHaut.rotation = SP_D2R(90);
    scoreEnHaut.x = 320;
    
    particleTaken = [[AnimationSequence alloc] initWithTextureAtlas:[SPTextureAtlas atlasWithContentsOfFile:@"particulesMulti.xml"] andAnimations:[NSArray arrayWithObjects:@"rougeParticulesRecolte", @"jauneParticulesRecolte", nil] andFirstAnimation:[worldColor stringByAppendingString:@"ParticulesRecolte"]];
    
    [self.stage addChild:particleTaken];
    [particleTaken changeAnimation:[worldColor stringByAppendingString:@"ParticulesRecolte"] withLoop:NO];
    particleTaken.x = 170;
    particleTaken.y = [worldColor isEqualToString:@"jaune"] ? -90 : -10;
}

- (void) destroy {
    
    [self.stage removeChild:autoDrive];
    [autoDrive removeEventListener:@selector(onAutoDriveTouched:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    autoDrive = nil;
    
    [self.stage removeChild:particleTaken];
    particleTaken = nil;
    
    [bus destroy];
    [creationRuntime destroy];
    
    bus = nil;
    creationRuntime = nil;
    
    animEcranNoir = nil;
    animHero = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [ecranFumeeContainer removeAllChildren];
    [self.stage removeChild:ecranFumeeContainer];
    ecranFumeeContainer = nil;
    
    [self removeChild:resultat];
    resultat = nil;
    
    [self removeChild:jauge];
    [jauge destroy];
    jauge = nil;
    
    [self removeChild:scoreTf];
    scoreTf = nil;
    
    [self removeChild:score];
    [score destroy];
    score = nil;
    
    if (tf1 && tf2) {
        
        [self.stage removeChild:tf1];
        [self.stage removeChild:tf2];
        
        tf1 = nil;
        tf2 = nil;
    }
    
    [super destroy];
}

- (void) onAutoDriveTouched:(SPTouchEvent *) event {
    
    [hero startAutoDrive];
}

- (void) prochainArret:(NSNotification *) notification {
    
    scoreTf = [[SPTextField alloc] initWithText:@"Score du Monde"];
    scoreTf.fontName = @"Kohicle25";
    scoreTf.fontSize = 36;
    scoreTf.width = 160;
    [self addChild:scoreTf];
    scoreTf.x = hero.x + 1870;
    scoreTf.y = 30;
    
    score = [[Couleurs alloc] init];
    score.x = hero.x + 1830;
    score.y = 105;
    [self addChild:score];
    
    jauge = [[Jauge alloc] initWithColor:worldColor andPourcentage:(int)[Stats pourcentageParticule]];
    [self addChild:jauge];
    jauge.x = hero.x + 1935;
    jauge.y = 220;
    
    resultat = [[SPTextField alloc] initWithText:[NSString stringWithFormat:@"%d", (int)[Stats pourcentageParticule]]];
    resultat.fontName = @"Kohicle25";
    resultat.fontSize = 34;
    [self addChild:resultat];
    resultat.x = hero.x + 1915;
    resultat.y = 160;
    resultat.text = [resultat.text stringByAppendingString:@"%"];
}

- (void) arretProche:(NSNotification *) notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changerPositionScore" object:nil];
    
    [self.stage removeChild:scoreEnHaut];
    [scoreEnHaut destroy];
    scoreEnHaut = nil;
}

- (void) finNiveau:(NSNotification *) notification {
    
    hero.move = FALSE;
}

- (void) colorPicked:(NSNotification *) notification {
    
    if ([notification.name isEqualToString:@"piege"]) {
        
        [ColorManager removePoints:10 forColorId:worldColor];
        
    } else if ([notification.name isEqualToString:@"filtreDissociatif"]) {
        
        [ColorManager filterDissociateForColorId:[[notification userInfo] valueForKey:@"colorId"]];
        
    } else if ([notification.name isEqualToString:@"filtreAssociatif"]) {
        
        [ColorManager filterAssociateForColorId:[[notification userInfo] valueForKey:@"colorId"]];
        
        tf1 = [SPTextField textFieldWithText:@"MISSION RÉUSSIE !"];
        tf2 = [SPTextField textFieldWithText:@"125 pigments orange à récolter"];
        tf1.width = 300;
        tf2.width = 300;
        tf1.fontName = tf2.fontName = @"Tw Cen MT";
        tf1.fontSize = 25;
        tf2.fontSize = 15;
        
        [self.stage addChild:tf1];
        [self.stage addChild:tf2];
        tf1.rotation = tf2.rotation = SP_D2R(90);
        tf1.x = 370;
        tf1.y = 170;
        tf2.x = 350;
        tf2.y = 170;
        
        SPTween *tween1 = [SPTween tweenWithTarget:tf1 time:1];
        tween1.delay = 2;
        [tween1 animateProperty:@"alpha" targetValue:0];
        [[SPStage mainStage].juggler addObject:tween1];
        
        SPTween *tween2 = [SPTween tweenWithTarget:tf2 time:1];
        tween2.delay = 2.3;
        [tween2 animateProperty:@"alpha" targetValue:0];
        [[SPStage mainStage].juggler addObject:tween2];
        
    } else {
        
        [ColorManager addPoints:1 forColorId:notification.name];
        [particleTaken changeAnimation:[worldColor stringByAppendingString:@"ParticulesRecolte"] withLoop:NO];
    }
    
    [scoreEnHaut update];
}

- (void) baddyManagement:(NSNotification *) notification {
    
    EcranFumee *ecranFumee = [[EcranFumee alloc] initWithAnimationSequence:animEcranNoir];
    [ecranFumeeContainer addChild:ecranFumee];
}

@end