//
//  TodoTableView.h
//  TODO
//
//  Created by 下村 翔 on 5/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TodoTableView : NSTableView {

}

@end

@interface NSObject (TodoTableViewDelegate)

-(BOOL)tableView:(NSTableView *)tableView keyDown:(NSEvent *)theEvent;

@end