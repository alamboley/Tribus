//
//  BigPicture.h
//  ChipmunkWrapper
//
//  Created by Aymeric Lamboley on 13/03/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "CitrusObject.h"

@interface BigPicture : CitrusObject {
    
    CitrusObject *hero;
}

- (id) initWithName:(NSString *)paramName params:(NSDictionary *)params andWorld:(NSString *)world;

@end
