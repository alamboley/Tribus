//
//  PouvoirExchange.h
//  ChipmunkWrapper
//
//  Created by Mac on 31/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//
#import "SPSprite.h"

@interface PouvoirExchange : SPSprite{
    NSTimer *timer;
    float timerCount;
    SPImage *image;
}
-(id)initWithImage:(NSString*) imageUrl;
-(void)destroy;
-(void)start;
@end
