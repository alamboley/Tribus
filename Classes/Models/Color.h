//
//  Color.h
//  Tribus
//
//  Created by lbineau on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Color : NSObject
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) UIColor *color;
- (id)initWithCode:(NSString *)code andLabel:(NSString *)label;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
@end
