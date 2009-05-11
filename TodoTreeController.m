//
//  TodoTreeController.m
//  TODO
//
//  Created by 下村 翔 on 5/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TodoTreeController.h"
#import "Task.h"

@implementation TodoTreeController

-(id) arrangedObjects
{
	id mycontent = [super arrangedObjects];
	NSLog(@"%@", mycontent);
	return mycontent;
}


@end
