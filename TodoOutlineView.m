//
//  TodoOutlineView.m
//  TODO
//
//  Created by 下村 翔 on 4/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TodoOutlineView.h"


@implementation TodoOutlineView

-(void)keyDown:(NSEvent *)theEvent
{
	id delegate = [self delegate];
	if ([delegate respondsToSelector:@selector(outlineView:keyDown:)])
	{
		if(![delegate outlineView:self keyDown:theEvent])
		{
			[super keyDown:theEvent];
		}
	} else {
		[super keyDown:theEvent];
	}
}

@end
