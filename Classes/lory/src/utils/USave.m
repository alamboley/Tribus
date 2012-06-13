//
//  USave.m
//  Tribus
//
//  Created by lbineau on 17/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "USave.h"
#import "SBJsonParser.h"

@implementation USave
/** Loads user preferences database from Settings.bundle plists. */
+ (void)initSettingsDefaults
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	//Determine the path to our Settings.bundle.
	NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
	NSString *settingsBundlePath = [bundlePath stringByAppendingPathComponent:@"Settings.bundle"];
    
	// Load paths to all .plist files from our Settings.bundle into an array.
	NSArray *allPlistFiles = [NSBundle pathsForResourcesOfType:@"plist" inDirectory:settingsBundlePath];
    
	// Put all of the keys and values into one dictionary,
	// which we then register with the defaults.
	NSMutableDictionary *preferencesDictionary = [NSMutableDictionary dictionary];
    
	// Copy the default values loaded from each plist
	// into the system's sharedUserDefaults database.
	NSString *plistFile;
	for (plistFile in allPlistFiles)
	{
        
		// Load our plist files to get our preferences.
		NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
		NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];
        
		// Iterate through the specifiers, and copy the default
		// values into the DB.
		NSDictionary *item;
		for(item in preferencesArray)
		{
			// Obtain the specifier's key value.
			NSString *keyValue = [item objectForKey:@"Key"];

			// Using the key, return the DefaultValue if specified in the plist.
			// Note: We won't know the object type until after loading it.
			id defaultValue = [item objectForKey:@"DefaultValue"];
            
			// Some of the items, like groups, will not have a Key, let alone
			// a default value.  We want to safely ignore these.
			if (keyValue && defaultValue)
			{
				[preferencesDictionary setObject:defaultValue forKey:keyValue];
			}
            
		}
        
	}
    
	// Ensure the version number is up-to-date, too.
	// This is, incidentally, how you update the value in a Title element.
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	NSString *shortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSString *versionLabel = [NSString stringWithFormat:@"%@ (%d)", shortVersion, [version intValue]];
	[standardUserDefaults setObject:versionLabel forKey:@"app_version_number"];
    
	// Now synchronize the user defaults DB in memory
	// with the persistent copy on disk.
	[standardUserDefaults registerDefaults:preferencesDictionary];
	[standardUserDefaults synchronize];
    
    NSLog(@"RESET APP : %@",[standardUserDefaults valueForKey:@"resetApp"]);
    if([standardUserDefaults boolForKey:@"resetApp"]){
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];        
    }

}
/**
 * value : la valeur à sauvegarder (wrapper les "int" "float" "bool" dans un NSNumber)
 * itemId : l'id à enregistrer (à récupérer du JSON la plupart du temps
 * type : l'identifiant de la categorie
 */
+ (void) saveValue:(id) value forItemId:(NSString*) itemId forCategory: (NSString*) category{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary *items;
    if([pref dictionaryForKey:category] == nil) items = [[NSMutableDictionary alloc] initWithObjectsAndKeys:value, itemId, nil];
    else items = [[NSMutableDictionary alloc] initWithDictionary:[pref dictionaryForKey:category]];
    
    [items setValue:[NSNumber numberWithBool:YES] forKey:itemId];
    
    [pref setValue:items forKey:category];            
    [pref synchronize];
}
+ (NSDictionary*)getItemIdsforType:(NSString*) type{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *items;
    if([pref dictionaryForKey:type] == nil) items = [[NSDictionary alloc] init];
    else items = [[NSDictionary alloc] initWithDictionary:[pref dictionaryForKey:type]];
    return items;
}
+ (NSArray*)getArrayForJsonPath:(NSString*) path{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];    
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSArray *res = [parser objectWithString:json_string error:nil];
    return res;
}
@end
