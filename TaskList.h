//
//  TaskList.h
//  TODO
//
//  Created by 下村 翔 on 5/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Task;

@interface TaskList :  NSManagedObject  
{
}

@property (retain) NSString * listname;
@property (retain) NSNumber * listid;
@property (retain) NSSet* tasks;

@end

@interface TaskList (CoreDataGeneratedAccessors)
- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)value;
- (void)removeTasks:(NSSet *)value;

@end

