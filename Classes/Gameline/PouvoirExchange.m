//
//  PouvoirExchange.m
//  ChipmunkWrapper
//
//  Created by Mac on 31/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "PouvoirExchange.h"

@implementation PouvoirExchange
-(id)initWithImage:(NSString*) imageUrl{
    if(self = [super init]){
        image = [SPImage imageWithContentsOfFile:imageUrl];
        [self addChild:image];
    }
    return self;
}
- (void) start{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.004
                                             target:self
                                           selector:@selector(timerAction)
                                           userInfo:nil
                                            repeats:YES];
    timerCount = PI;
}
- (void)timerAction{
    image.y = (self.stage.width * 0.5) + cos(timerCount) * self.stage.width * 0.5 - (image.width * 0.5);
    //    image.x = (self.stage.height * 0.5) + sin(timerCount) * self.stage.height * 0.5 - (image.height * 0.5);
    image.x = image.height + self.stage.height - (timerCount * 30);
    // NSLog(@"%f",image.y);
    timerCount+=0.01;
    if(image.x < -image.width)
        [timer invalidate];
}
-(void)destroy{
    [self removeAllChildren];
    [timer invalidate];
    timer = nil;
}
@end
