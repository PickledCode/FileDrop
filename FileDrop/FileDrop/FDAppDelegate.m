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
    //FDFileManager *fm = [[FDFileManager alloc] initWithToken:@"test" delegate:nil];
    //NSLog(@"FM: %@", fm);
    //[fm sendFileWithPath:@"/Users/ryansullivan/Desktop/FileDrop.zip"];
    
    FDTransferWindowController *transfer = [FDTransferWindowController transferWindowControllerWithTitle:@"Session 1"];
    [transfer showWindow:nil];
    
    [sessionWindows addObject:transfer];
}

@end
