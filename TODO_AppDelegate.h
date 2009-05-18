//
//  TODO_AppDelegate.h
//  TODO
//
//  Created by ?? ? on 4/9/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TODO_AppDelegate : NSObject 
{
    IBOutlet NSWindow *window;
	IBOutlet NSWindow *hudwindow;
	IBOutlet NSTableView *todoTableView;
	
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;

- (IBAction)saveAction:sender;
- (IBAction)completeTask:sender;

- (IBAction)updateAllListsAndTasks:sender;

@end
