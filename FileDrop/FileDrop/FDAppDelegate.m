//
//  FDAppDelegate.m
//  FileDrop
//
//  Created by Ryan Sullivan on 11/8/11.
//  Copyright (c) 2011 Freelance Web Developer. All rights reserved.
//

#import "FDAppDelegate.h"
#import "FDTransferWindowController.h"

@implementation FDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    sessionWindows = [NSMutableArray new];
    sessionAmount = 0;
    
    // On launch, new window
    [self newSession:nil];
}

-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    NSLog(@"-appShouldHandleReopen... Flag: %d, sessionWindows: %lu", flag, [sessionWindows count]);
    if (flag == NO) {
        if ([sessionWindows count] < 1) {
            [self newSession:nil];
        }
    }
    return YES;
}


-(IBAction)newSession:(id)sender {
    sessionAmount++;
    
    NSString *sessionTitle = [NSString stringWithFormat:@"Session %lu", sessionAmount];
    FDTransferWindowController *transfer = [FDTransferWindowController transferWindowControllerWithTitle:sessionTitle];
    
    [transfer showWindow:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(windowClosed:) 
                                                 name:NSWindowWillCloseNotification 
                                               object:transfer.window];
    [sessionWindows addObject:transfer];
}

-(void)windowClosed:(NSNotification*)notif {
    NSWindow *sender = [notif object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:NSWindowWillCloseNotification 
                                                  object:sender];
    
    NSWindowController *controller = [sender windowController];
    [sessionWindows removeObject:controller];
}

@end
