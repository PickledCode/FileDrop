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

-(IBAction)newSession:(id)sender {
    sessionAmount++;
    
    NSString *sessionTitle = [NSString stringWithFormat:@"Session %lu", sessionAmount];
    FDTransferWindowController *transfer = [FDTransferWindowController transferWindowControllerWithTitle:sessionTitle];
    
    [transfer showWindow:nil];
    [sessionWindows addObject:transfer];
}

@end
