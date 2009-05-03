//
//  TODO_AppDelegate.m
//  TODO
//
//  Created by ?? ? on 4/9/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import "TODO_AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import "Task.h"

@implementation TODO_AppDelegate

static NSString *apiKey = @"5a98a85fa1591ea18410784a2fd97669";


/**
    Returns the support folder for the application, used to store the Core Data
    store file.  This code uses a folder named "TODO" for
    the content, either in the NSApplicationSupportDirectory location or (if the
    former cannot be found), the system's temporary directory.
 */

- (NSString *)applicationSupportFolder {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
    return [basePath stringByAppendingPathComponent:@"TODO"];
}


/**
    Creates, retains, and returns the managed object model for the application 
    by merging all of the models found in the application bundle.
 */
 
- (NSManagedObjectModel *)managedObjectModel {

    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
	
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
    Returns the persistent store coordinator for the application.  This 
    implementation will create and return a coordinator, having added the 
    store for the application to it.  (The folder for the store is created, 
    if necessary.)
 */

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {

    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }

    NSFileManager *fileManager;
    NSString *applicationSupportFolder = nil;
    NSURL *url;
    NSError *error;
    
    fileManager = [NSFileManager defaultManager];
    applicationSupportFolder = [self applicationSupportFolder];
    if ( ![fileManager fileExistsAtPath:applicationSupportFolder isDirectory:NULL] ) {
        [fileManager createDirectoryAtPath:applicationSupportFolder attributes:nil];
    }
    
    url = [NSURL fileURLWithPath: [applicationSupportFolder stringByAppendingPathComponent: @"TODO.xml"]];
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]){
        [[NSApplication sharedApplication] presentError:error];
    }    

    return persistentStoreCoordinator;
}


/**
    Returns the managed object context for the application (which is already
    bound to the persistent store coordinator for the application.) 
 */
 
- (NSManagedObjectContext *) managedObjectContext {

    if (managedObjectContext != nil) {
        return managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}


/**
    Returns the NSUndoManager for the application.  In this case, the manager
    returned is that of the managed object context for the application.
 */
 
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}


/**
    Performs the save action for the application, which is to send the save:
    message to the application's managed object context.  Any encountered errors
    are presented to the user.
 */
 
- (IBAction) saveAction:(id)sender {

    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}


/**
    Implementation of the applicationShouldTerminate: method, used here to
    handle the saving of changes in the application managed object context
    before the application terminates.
 */
 
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {

    NSError *error;
    int reply = NSTerminateNow;
    
    if (managedObjectContext != nil) {
        if ([managedObjectContext commitEditing]) {
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
				
                // This error handling simply presents error information in a panel with an 
                // "Ok" button, which does not include any attempt at error recovery (meaning, 
                // attempting to fix the error.)  As a result, this implementation will 
                // present the information to the user and then follow up with a panel asking 
                // if the user wishes to "Quit Anyway", without saving the changes.

                // Typically, this process should be altered to include application-specific 
                // recovery steps.  

                BOOL errorResult = [[NSApplication sharedApplication] presentError:error];
				
                if (errorResult == YES) {
                    reply = NSTerminateCancel;
                } 

                else {
					
                    int alertReturn = NSRunAlertPanel(nil, @"Could not save changes while quitting. Quit anyway?" , @"Quit anyway", @"Cancel", nil);
                    if (alertReturn == NSAlertAlternateReturn) {
                        reply = NSTerminateCancel;	
                    }
                }
            }
        } 
        
        else {
            reply = NSTerminateCancel;
        }
    }
    
    return reply;
}


/**
    Implementation of dealloc, to release the retained variables.
 */
 
- (void) dealloc {

    [managedObjectContext release], managedObjectContext = nil;
    [persistentStoreCoordinator release], persistentStoreCoordinator = nil;
    [managedObjectModel release], managedObjectModel = nil;
    [super dealloc];
}

- (NSString *) createMD5String:(NSString *)orig {
	const char *test_cstr = [orig UTF8String];
	unsigned char md5_result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(test_cstr, strlen(test_cstr), md5_result);
	char md5cstring[CC_MD5_DIGEST_LENGTH*2];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		sprintf(md5cstring+i*2, "%02x", md5_result[i]);
	}
	return [NSString stringWithCString:md5cstring length:CC_MD5_DIGEST_LENGTH*2];
}

-(BOOL)outlineView:(NSOutlineView *)outlineView keyDown:(NSEvent *)theEvent
{
	NSString *text = [theEvent characters];
	
	if ([text isEqualToString:@" "])
	{
		if ([hudwindow isVisible]) {
			[hudwindow orderOut:self];
		} else {
			[hudwindow orderFront:self];
		}
		
		return YES;
	}
	
	return NO;
}
-(BOOL)panelWindow:(NSPanel *)panelWindow keyDown:(NSEvent *)theEvent
{
	NSString *text = [theEvent characters];
	
	if ([text isEqualToString:@" "])
	{
		if ([hudwindow isVisible]) {
			[hudwindow orderOut:self];
		} else {
			[hudwindow orderFront:self];
		}
		
		return YES;
	}
	
	return NO;
}

- (NSString *) createRtmQuery:(NSDictionary *)params
{
	NSString *secret = @"b16393df7a139ec4";
	NSArray *keys = [[params allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSMutableString *signature = [NSMutableString stringWithString:secret];
	
	// prepare api_sig
	for (NSString *key in keys)
	{
		NSString *val = [params objectForKey:key];
		[signature appendString:key];
		[signature appendString:val];
	}
	NSString *apiSig = [self createMD5String:signature];
	
	// prepare query
	NSMutableArray *pairs = [NSMutableArray arrayWithCapacity:5];
	[pairs addObject:[@"api_sig=" stringByAppendingString:apiSig]];
	for (NSString *key in keys)
	{
		NSString *val = [params objectForKey:key];
		[pairs addObject:[NSString stringWithFormat:@"%@=%@", key, val]];
	}
	return [pairs componentsJoinedByString:@"&"];
}

- (NSXMLElement *) performQuery:(NSString *)query
{
	BOOL asHTML = NO;
	NSURL *url = [NSURL URLWithString:query];
	NSError *error = nil;
	int options = (asHTML) ? NSXMLDocumentTidyHTML : 0;
	NSXMLDocument *document = [[[NSXMLDocument alloc]
								initWithContentsOfURL:url options:options error:&error] autorelease];
	return [document rootElement];
}


- (void) getAllTasks:(NSString *)token
{
	// get all tasks
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:apiKey forKey:@"api_key"];
	[params setObject:@"rtm.tasks.getList" forKey:@"method"];
	[params setObject:token forKey:@"auth_token"];
	NSString *requestURL = [@"http://api.rememberthemilk.com/services/rest/?" stringByAppendingString:[self createRtmQuery:params]];
	NSXMLElement *rootElement = [self performQuery:requestURL];
	NSArray *taskseriesArray = [rootElement nodesForXPath:@"/rsp/tasks/list/taskseries" error:nil];
	
	// create task
	for (int i=0; i < [taskseriesArray count]; i++)
	{
		NSXMLElement *taskseries = [taskseriesArray objectAtIndex:i];
		NSString *name = [[taskseries attributeForName:@"name"] stringValue];
		
		NSXMLElement *task = [[taskseries nodesForXPath:@"task" error:nil] objectAtIndex:0];
		NSString *ident = [[task attributeForName:@"id"] stringValue];
		
		// check if the task is already in the db
		NSFetchRequest *req = [[NSFetchRequest alloc] init];
		[req setEntity:[NSEntityDescription entityForName:@"Task" inManagedObjectContext:[self managedObjectContext]]];
		[req setPredicate:[NSPredicate predicateWithFormat:@"(ident = '%@')", ident]];
		NSError *err = nil;
		NSLog(@"%@", [[self managedObjectContext] executeFetchRequest:req error:&err]);
//		if ([[[self managedObjectContext] executeFetchRequest:req error:nil] count] != 0)
//		{
			Task *taskEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Task"
															 inManagedObjectContext:[self managedObjectContext]];
			taskEntity.ident = ident;
			taskEntity.due = [[task attributeForName:@"due"] stringValue];
			taskEntity.priority = [NSNumber numberWithInt:[[[task attributeForName:@"priority"] stringValue] intValue]];
			taskEntity.tags = nil;
			taskEntity.time = [[task attributeForName:@"estimate"] stringValue];
			taskEntity.completed = [[task attributeForName:@"completed"] stringValue];
			taskEntity.title = name;
			taskEntity.children = nil;
			taskEntity.notes = nil;
			taskEntity.parent = nil;
			taskEntity.tasklist = nil;
//		}
	}
}

/* This function is called after initiating application */
- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"myToken"];
	if (token) {
		NSLog(@"Token is found in defaults: %@", token);
	} else {
		// Get frob
		NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:5];
		[params setObject:apiKey forKey:@"api_key"];
		[params setObject:@"rtm.auth.getFrob" forKey:@"method"];
		NSString *requestURL = [@"http://api.rememberthemilk.com/services/rest/?" stringByAppendingString:[self createRtmQuery:params]];
		NSXMLElement *rootElement = [self performQuery:requestURL];
		NSArray *linkNodes = [rootElement nodesForXPath:@"//frob" error:nil];
		NSString *frob = [[linkNodes objectAtIndex:0] stringValue];
		NSLog(@"frob is %@", frob);
		
		// authorizer URL
		params = [NSMutableDictionary dictionaryWithCapacity:5];
		[params setObject:apiKey forKey:@"api_key"];
		[params setObject:@"read" forKey:@"perms"];
		[params setObject:frob forKey:@"frob"];
		requestURL = [@"http://www.rememberthemilk.com/services/auth/?" stringByAppendingString:[self createRtmQuery:params]];
		/* WAIT HERE FOR USER TO AUTHORIZE! */
		NSRunAlertPanel(@"Authorize me!", requestURL, @"OK", NULL, NULL);
		
		// get token
		params = [NSMutableDictionary dictionaryWithCapacity:5];
		[params setObject:apiKey forKey:@"api_key"];
		[params setObject:@"rtm.auth.getToken" forKey:@"method"];
		[params setObject:frob forKey:@"frob"];
		requestURL = [@"http://api.rememberthemilk.com/services/rest/?" stringByAppendingString:[self createRtmQuery:params]];
		rootElement = [self performQuery:requestURL];
		linkNodes = [rootElement nodesForXPath:@"//token" error:nil];
		NSString *token = [[linkNodes objectAtIndex:0] stringValue];
		NSLog(@"token is %@", token);

		// Save token
		if (token)
		{
			[[NSUserDefaults standardUserDefaults] setObject:token forKey:@"myToken"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		} else {
			NSLog(@"Error: couldn't get token");
			NSLog(@"query is %@", requestURL);
		}
	}
	
	// get all tasks
	[self getAllTasks:token];
}


@end
