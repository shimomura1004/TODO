//
//  TodoQLPanel.m
//  TODO
//
//  Created by 下村 翔 on 4/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TodoQLPanel.h"


@implementation TodoQLPanel

-(void)keyDown:(NSEvent *)theEvent
{	
	id delegate = [self delegate];
	if ([delegate respondsToSelector:@selector(panelWindow:keyDown:)])
	{
		if(![delegate panelWindow:self keyDown:theEvent])
		{
			[super keyDown:theEvent];
		}
	} else {
		[super keyDown:theEvent];
	}
}


@end
