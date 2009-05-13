//
//  Note.h
//  TODO
//
//  Created by 下村 翔 on 5/13/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Task;

@interface Note :  NSManagedObject  
{
}

@property (retain) NSString * content;
@property (retain) Task * task;

@end


