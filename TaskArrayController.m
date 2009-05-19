//
//  TaskArrayController.m
//  TODO
//
//  Created by 下村 翔 on 5/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TaskArrayController.h"
#import "Predicate.h"

@implementation TaskArrayController

- (void) awakeFromNib
{
	[super awakeFromNib];
	NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(onListChangeAction:)
			   name:NSTableViewSelectionDidChangeNotification object:listTableView];
	[nc addObserver:self selector:@selector(onListChangeAction:)
			   name:NSControlTextDidChangeNotification object:searchField];
}

- (void) updatePredicate
{
	NSArray *preds = [predicateController selectedObjects];
	Predicate *listpred = [preds objectAtIndex:0];

	if (![[searchField stringValue] isEqualToString:@""]) {
		NSString *searchpred = [[@"(title like[cd] '*"
								 stringByAppendingString:[searchField stringValue]]
								stringByAppendingString:@"*')"];
	
		NSArray *compp = [NSArray arrayWithObjects:
						  [NSPredicate predicateWithFormat:searchpred],
						  [NSPredicate predicateWithFormat:listpred.predicateString],
						  nil];
	
		[self setFilterPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:compp]];
	} else {
		[self setFilterPredicate:[NSPredicate predicateWithFormat:listpred.predicateString]];
	}
	NSLog(@"Predicate: %@", [self filterPredicate]);
}

- (void) onListChangeAction:(NSNotification *)ntf
{
	[self updatePredicate];
}

@end
