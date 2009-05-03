//
//  Task.h
//  TODO
//
//  Created by 下村 翔 on 5/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Task :  NSManagedObject  
{
}

@property (retain) NSString * completed;
@property (retain) NSNumber * rtmid;
@property (retain) NSString * title;
@property (retain) NSString * due;
@property (retain) NSString * tags;
@property (retain) NSString * time;
@property (retain) NSNumber * priority;
@property (retain) Task * parent;
@property (retain) NSManagedObject * tasklist;
@property (retain) NSSet* children;
@property (retain) NSSet* notes;

@end

@interface Task (CoreDataGeneratedAccessors)
- (void)addChildrenObject:(Task *)value;
- (void)removeChildrenObject:(Task *)value;
- (void)addChildren:(NSSet *)value;
- (void)removeChildren:(NSSet *)value;

- (void)addNotesObject:(NSManagedObject *)value;
- (void)removeNotesObject:(NSManagedObject *)value;
- (void)addNotes:(NSSet *)value;
- (void)removeNotes:(NSSet *)value;

@end

