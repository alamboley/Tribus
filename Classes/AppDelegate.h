#import <UIKit/UIKit.h>
#import "ColorManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ColorManager *colorManager;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end
