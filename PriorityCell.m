//
//  PriorityCell.m
//  TODO
//
//  Created by 下村 翔 on 4/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PriorityCell.h"


@implementation PriorityCell

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	switch ([[self objectValue] intValue]) {
		case 1:
			[[NSColor redColor] set];
			break;
		case 2:
			[[NSColor blueColor] set];
			break;
		case 3:
			[[NSColor cyanColor] set];
			break;
		default:
			[[NSColor whiteColor] set];
			break;
	}
	NSRectFill(cellFrame);
}

@end

