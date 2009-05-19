//
//  TaskArrayController.h
//  TODO
//
//  Created by 下村 翔 on 5/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TaskArrayController : NSArrayController {
	IBOutlet NSSearchField *searchField;
	IBOutlet NSTableView *listTableView;
	IBOutlet NSArrayController *predicateController;
}

@end
