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
	NSMutableArray *allPredicates = [NSMutableArray arrayWithCapacity:3];
	// predicate of list
	NSArray *preds = [predicateController selectedObjects];
	Predicate *listpred = [preds objectAtIndex:0];
	if (![listpred.predicateString isEqualToString:@""])
	{
		[allPredicates addObject:[NSPredicate predicateWithFormat:listpred.predicateString]];
	}

	// predicate of searchfield
	if (![[searchField stringValue] isEqualToString:@""]) {
		NSString *searchpred = [NSString stringWithFormat:@"(title like[cd] '*%@*')",
								[searchField stringValue]];
		[allPredicates addObject:[NSPredicate predicateWithFormat:searchpred]];
	}

	// end of predicates array
	//[allPredicates addObject:nil];
	[self setFilterPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:allPredicates]];

	NSLog(@"Predicate: %@", [self filterPredicate]);
}

- (void) onListChangeAction:(NSNotification *)ntf
{
	[self updatePredicate];
}

@end
