//
//  TodoOutlineView.h
//  TODO
//
//  Created by 下村 翔 on 4/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TodoOutlineView : NSOutlineView {

}

@end

@interface NSObject (TodoOutlineViewDelegate)

-(BOOL)outlineView:(NSOutlineView *)outlineView keyDown:(NSEvent *)theEvent;

@end
