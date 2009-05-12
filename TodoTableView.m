//
//  TodoTableView.m
//  TODO
//
//  Created by 下村 翔 on 5/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TodoTableView.h"


@implementation TodoTableView

-(void)keyDown:(NSEvent *)theEvent
{
	id delegate = [self delegate];
	if ([delegate respondsToSelector:@selector(tableView:keyDown:)])
	{
		if(![delegate tableView:self keyDown:theEvent])
		{
			[super keyDown:theEvent];
		}
	} else {
			[super keyDown:theEvent];
	}
}

@end
