//
//  USave.h
//  Tribus
//
//  Created by lbineau on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface USave : NSObject
+ (void)initSettingsDefaults;
+ (void) saveItemId:(NSString*) itemId forType: (NSString*) type;
+ (NSDictionary*)getItemIdsforType:(NSString*) type;
@end
