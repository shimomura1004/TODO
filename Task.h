//
//  Task.h
//  TODO
//
//  Created by 下村 翔 on 5/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Note;
@class TaskList;

@interface Task :  NSManagedObject  
{
}

@property (retain) NSNumber * taskid;
@property (retain) NSString * due;
@property (retain) NSString * completed;
@property (retain) NSString * tags;
@property (retain) NSString * time;
@property (retain) NSString * title;
@property (retain) NSNumber * priority;
@property (retain) NSSet* notes;
@property (retain) TaskList * tasklist;

@end

@interface Task (CoreDataGeneratedAccessors)
- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)value;
- (void)removeNotes:(NSSet *)value;

@end

