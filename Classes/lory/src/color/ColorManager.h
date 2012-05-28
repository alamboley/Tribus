//
//  ColorUIViewController.h
//  Tribus
//
//  Created by lbineau on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorManager : NSObject

+ (void) addPoints:(int) points forColorId:(NSString*) colorId;
+ (BOOL) removePoints:(int) points forColorId:(NSString*) colorId;
+ (void) filterDissociateForColorId:(NSString*) colorId;
+ (void) saveColorId:(NSString*) colorId;
+ (NSMutableDictionary*) getColors;
+ (void)initManager;
@end
