//
//  TodoQLPanel.h
//  TODO
//
//  Created by 下村 翔 on 4/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TodoQLPanel : NSPanel {

}

@end

@interface NSObject (TodoQLPanelDelegate)

-(BOOL)panelWindow:(NSPanel *)panelWindow keyDown:(NSEvent *)theEvent;

@end
