//
//  EcranFumee.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "SPSprite.h"
#import "AnimationSequence.h"

@interface EcranFumee : SPSprite {
    
    AnimationSequence *anim;
}

- (id) initWithXML:(NSString *) atlasXML;

@end
