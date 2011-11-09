//
//  FDAppDelegate.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/8/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDAppDelegate.h"

@implementation FDAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    CGRect b = NSRectToCGRect(self.window.frame);
    //CGRect b = CGRectMake(self.window.frame.origin.x, self.window.frame.origin.y, self.window.frame.size.width, self.window.frame.size.height);
    
    /* TUINSView is the bridge between the standard AppKit NSView-based heirarchy and the TUIView-based heirarchy */
	TUINSView *tuiTableViewContainer = [[TUINSView alloc] initWithFrame:b];
	[self.window setContentView:tuiTableViewContainer];
	[tuiTableViewContainer release];
	
    FDMainView *mainView = [[FDMainView alloc] initWithFrame:b];
    tuiTableViewContainer.rootView = mainView;
    [mainView release];
}

@end
